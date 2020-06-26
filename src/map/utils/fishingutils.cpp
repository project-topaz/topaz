/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "../../common/showmsg.h"

#include <string.h> 
#include <math.h>

#include "../ai/ai_container.h"
#include "../entities/battleentity.h"
#include "../entities/mobentity.h"
#include "../entities/npcentity.h"
#include "../lua/luautils.h"
#include "../packets/caught_fish.h"
#include "../packets/caught_monster.h"
#include "../packets/char_update.h"
#include "../packets/char_skills.h"
#include "../packets/char_sync.h"
#include "../packets/entity_animation.h"
#include "../packets/entity_update.h"
#include "../packets/event.h"
#include "../packets/fishing.h"
#include "../packets/inventory_item.h"
#include "../packets/inventory_finish.h"
#include "../packets/message_name.h"
#include "../packets/message_text.h"
#include "../packets/message_special.h"
#include "../packets/message_system.h"
#include "../packets/release.h"
#include "../enmity_container.h"
#include "../item_container.h"
#include "../map.h"
#include "../modifier.h"
#include "../navmesh.h"
#include "../status_effect.h"
#include "../status_effect_container.h"
#include "../universal_container.h"
#include "../vana_time.h"
#include "battleutils.h"
#include "charutils.h"
#include "fishingutils.h"
#include "itemutils.h"
#include "zoneutils.h"

namespace fishingutils
{

    uint16 MessageOffset[MAX_ZONEID];

    void LoadFishingMessages()
    {
        zoneutils::ForEachZone([](CZone* PZone) {
            MessageOffset[PZone->GetID()] = luautils::GetTextIDVariable(PZone->GetID(), "FISHING_MESSAGE_OFFSET");
        });
    }
        
    uint16 GetMessageOffset(uint16 ZoneID)
    {
        return MessageOffset[ZoneID];
    }
    /*
    const char *GetCharIP(CCharEntity* PChar)
    {
        uint32 client_addr = 0;
        int ret = Sql_Query(SqlHandle, "SELECT client_addr FROM accounts_sessions WHERE charid=%u LIMIT 1;", PChar->id);
        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            client_addr = (uint32)Sql_GetUIntData(SqlHandle, 0);
            return ip2str(client_addr);
        }
        return "0.0.0.0";
    }
    */
    void AddFishingLog(CCharEntity* PChar)
    {
        const char* catchName = "Unknown";
        switch (PChar->hookedFish->catchtype) {
        case FISHINGCATCHTYPE_SMALLFISH:
        case FISHINGCATCHTYPE_BIGFISH:
        case FISHINGCATCHTYPE_ITEM: {
            CItem* PItem = itemutils::GetItem(PChar->hookedFish->catchid);
            if (PItem != nullptr)
                catchName = (char*)PItem->getName();
            break;
        }
        case FISHINGCATCHTYPE_MOB: {
            CMobEntity* PMob = (CMobEntity*)zoneutils::GetEntity(PChar->hookedFish->catchid, TYPE_MOB);
            if (PMob != nullptr)
                catchName = (char*)PMob->GetName();
            break;
        }
        default:

            break;
        }
        
        const char* fmtQuery = "INSERT into fishing_log (zone,area,charid,charname,charlevel,charskill,pos_x,pos_y,pos_z,catchtype,catchid,catchname,catchskill,regen) "
                               "VALUES(%u,%u,%u,'%s',%u,%u,%.3f,%.3f,%.3f,%u,%u,'%s',%u,%u)";
        if (Sql_Query(SqlHandle, fmtQuery,
            PChar->getZone(),
            PChar->hookedFish->areaid,
            PChar->id,
            PChar->GetName(),
            PChar->GetMLevel(),
            PChar->RealSkills.skill[SKILL_FISHING],
            PChar->loc.p.x,
            PChar->loc.p.y,
            PChar->loc.p.z,
            PChar->hookedFish->catchtype,
            PChar->hookedFish->catchid,
            catchName,
            PChar->hookedFish->catchlevel,
            PChar->hookedFish->regen) == SQL_ERROR)
        {
            ShowError("cmdhandler::call: Failed to log fishing catch record.\n");
        }

    }

    bool LureLoss(CCharEntity* PChar, bool RemoveFly, bool SendUpdate)
    {
        CItemWeapon* PLure = (CItemWeapon*)PChar->getEquip(SLOT_AMMO);

        TPZ_DEBUG_BREAK_IF(PLure == nullptr);
        TPZ_DEBUG_BREAK_IF(PLure->isType(ITEM_WEAPON) == false);
        TPZ_DEBUG_BREAK_IF(PLure->getSkillType() != SKILL_FISHING);

        if (PLure != nullptr) {
            if (!RemoveFly &&
                (PLure->getStackSize() == 1))
            {
                return false;
            }
            if (PChar->hookedFish->successtype != FISHINGSUCCESSTYPE_CATCHITEM) {
                if (PLure->getQuantity() == 1)
                {
                    charutils::UnequipItem(PChar, SLOT_AMMO, false);
                }
                charutils::UpdateItem(PChar, PLure->getLocationID(), PLure->getSlotID(), -1);
                if (SendUpdate)
                {
                    PChar->pushPacket(new CInventoryFinishPacket());
                }
            }
        }
        return true;
    }

    void RodBreak(CCharEntity* PChar)
    {
        CItemWeapon* PRod = (CItemWeapon*)PChar->getEquip(SLOT_RANGED);
        
        TPZ_DEBUG_BREAK_IF(PRod == nullptr);
        if (PRod != nullptr) {
            uint8 Breakable = 0;
            uint16 BrokenRodID = 0;
            int32 ret = Sql_Query(SqlHandle, "SELECT breakable,broken_rodid FROM `fishing_rod` WHERE rodid=%u", PRod->getID());

            if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS && Sql_GetUIntData(SqlHandle, 0) > 0)
            {
                Breakable = Sql_GetUIntData(SqlHandle, 0);
                BrokenRodID = Sql_GetUIntData(SqlHandle, 1);
            }

            if (Breakable > 0 && BrokenRodID > 0)
            {
                LureLoss(PChar, true, false);
                charutils::UnequipItem(PChar, SLOT_RANGED, false);
                uint8 location = PRod->getLocationID();
                charutils::UpdateItem(PChar, location, PRod->getSlotID(), -1);
                charutils::AddItem(PChar, location, BrokenRodID, 1);
                PChar->pushPacket(new CInventoryFinishPacket());
            }
        }
    }

    bool CanFishMob(CMobEntity* PMob) {
        return (PMob != nullptr &&
            //!PMob->PAI->IsSpawned() &&
            PMob->status == 2 &&
            PMob->GetLocalVar("hooked") == 1);
    }

    #define MAX_POINTS 10000
    // Given three colinear areavector_ts p, q, r, the function checks if areavector_t q lies on line segment 'pr'
    bool onSegment(areavector_t p, areavector_t q, areavector_t r)
    {
        if (q.x <= std::max(p.x, r.x) && q.x >= std::min(p.x, r.x) &&
            q.z <= std::max(p.z, r.z) && q.z >= std::min(p.z, r.z))
            return true;
        return false;
    }
    // To find orientation of ordered triplet (p, q, r).
    int orientation(areavector_t p, areavector_t q, areavector_t r)
    {
        float val = std::round(q.z - p.z) * (r.x - q.x) - (q.x - p.x) * (r.z - q.z);
        if (val == 0) return 0;  
        return (val > 0) ? 1 : 2; 
    }
    // The function that returns true if line segment 'p1q1' and 'p2q2' intersect.
    bool doIntersect(areavector_t p1, areavector_t q1, areavector_t p2, areavector_t q2)
    {
        int o1 = orientation(p1, q1, p2);
        int o2 = orientation(p1, q1, q2);
        int o3 = orientation(p2, q2, p1);
        int o4 = orientation(p2, q2, q1);

        if (o1 != o2 && o3 != o4) return true;

        if (o1 == 0 && onSegment(p1, p2, q1)) return true;
        if (o2 == 0 && onSegment(p1, q2, q1)) return true;
        if (o3 == 0 && onSegment(p2, p1, q2)) return true;
        if (o4 == 0 && onSegment(p2, q1, q2)) return true;

        return false; 
    }
    // Returns true if the areavector_t p lies inside the polygon[] with n vertices
    bool isInsidePoly(areavector_t polygon[], int n, areavector_t p, float posy, uint8 height)
    {
        if (p.y < (posy - (height / 2)) || p.y >(posy + (height / 2))) return false;
        if (n < 3)  return false;
        areavector_t extreme = { MAX_POINTS, p.z };
        int count = 0, i = 0;
        do
        {
            int next = (i + 1) % n;
            if (doIntersect(polygon[i], polygon[next], p, extreme))
            {
                if (orientation(polygon[i], p, polygon[next]) == 0)
                    return onSegment(polygon[i], p, polygon[next]);
                count++;
            }
            i = next;
        } while (i != 0);
        return count & 1; 
    }
    bool isInsideCylinder(areavector_t center, areavector_t p, uint16 radius, uint8 height) {
        if (p.y < (center.y - (height / 2)) || p.y >(center.y + (height / 2))) return false;
        float dx = std::abs(p.x - center.x);
        if (dx >  radius) return false;
        float dz = std::abs(p.z - center.z);
        if (dz >  radius) return false;
        if (dx + dz <= radius) return true;
        return (dx*dx + dz*dz <= radius*radius);
        return true;
    }
    void EE(CCharEntity* PChar, CItemWeapon* Rod) {
        int8 encodedSignature[12] = { 86,-36,-85,118,-98,62,-49,96,0,0,0,0 };
        Rod->setSignature(encodedSignature);
        PChar->pushPacket(new CInventoryItemPacket(Rod, Rod->getLocationID(), Rod->getSlotID()));
        PChar->pushPacket(new CInventoryFinishPacket());
    }

    fishingarea_t *GetFishingArea(CCharEntity* PChar) {
        int16 zoneId = PChar->getZone();
        position_t p = PChar->loc.p;
        areavector_t loc = { p.x, p.y, p.z };

        int32 ret = Sql_Query(SqlHandle, "SELECT fa.areaid,fa.bound_type,fa.bound_height,fa.bounds,fa.center_x,fa.center_y,fa.center_z,fa.bound_radius,fa.name,fz.difficulty FROM `fishing_area` fa LEFT JOIN fishing_zone fz ON fz.zoneid = fa.zoneid WHERE fa.zoneid=%u", zoneId);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            fishingarea_t *fishingArea = new fishingarea_t();

            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                fishingArea->areaId = Sql_GetUIntData(SqlHandle, 0);
                fishingArea->areatype = Sql_GetUIntData(SqlHandle, 1);
                fishingArea->height = Sql_GetUIntData(SqlHandle, 2);
                fishingArea->center.x = Sql_GetFloatData(SqlHandle, 4);
                fishingArea->center.y = Sql_GetFloatData(SqlHandle, 5);
                fishingArea->center.z = Sql_GetFloatData(SqlHandle, 6);
                fishingArea->radius = Sql_GetUIntData(SqlHandle, 7);
                fishingArea->areaName.clear();
                fishingArea->areaName.insert(0, (const char*)Sql_GetData(SqlHandle, 8));
                fishingArea->difficulty = Sql_GetUIntData(SqlHandle, 9);

                switch (fishingArea->areatype) {
                case 0: // Whole Zone
                    return fishingArea;
                    break;
                case 1: // Radial Boundary                    
                    if (isInsideCylinder(fishingArea->center, loc, fishingArea->radius, fishingArea->height)) {
                        return fishingArea;
                    }
                    break;
                case 2: // Poly Boundary
                    size_t length = 0;
                    char* bounds = nullptr;
                    bool foundInBounds = false;

                    Sql_GetData(SqlHandle, 3, &bounds, &length);
                    fishingArea->numBounds = (uint8)length / sizeof(areavector_t);
                    areavector_t* areaBounds = new areavector_t[fishingArea->numBounds];

                    for (int i = 0; i < fishingArea->numBounds; i++) {
                        memcpy((void*)&areaBounds[i], &bounds[i * sizeof(areavector_t)], sizeof(areavector_t));
                    }

                    if (isInsidePoly(areaBounds, fishingArea->numBounds, loc, fishingArea->center.y, fishingArea->height)) {
                        foundInBounds = true;
                    }

                    if (areaBounds != nullptr) {
                        delete areaBounds;
                        areaBounds = nullptr;
                    }

                    if (foundInBounds) {
                        return fishingArea;
                    }

                    break;
                }
            }
        }

        return nullptr;
    }

    std::vector<fish_t> *GetFishingAreaFish(uint16 zoneId, uint16 areaId, uint16 lureId)
    {
       
        const char* Query =
            "SELECT "
            "distinct " 
            "ff.fishid, "               // 0
            "ff.name, "                 // 1
            "ff.min_skill_level, "      // 2
            "ff.skill_level, "          // 3
            "ff.size, "                 // 4
            "ff.base_delay, "           // 5
            "ff.base_move, "            // 6
            "ff.min_length, "           // 7
            "ff.max_length, "           // 8
            "ff.size_type, "            // 9
            "ff.water_type, "           // 10
            "ff.log, "                  // 11
            "ff.quest, "                // 12
            "ff.flags, "                // 13
            "ff.legendary, "            // 14
            "ff.legendary_flags, "      // 15
            "ff.item, "                 // 16
            "ff.max_hook, "             // 17
            "ff.rarity, "               // 18
            "ff.required_keyitem, "     // 19
            "ff.required_catches, "     // 20
            "fla.power "                // 21
            "FROM fishing_lure_affinity fla "
            "LEFT JOIN fishing_fish ff "
            "ON ff.fishid = fla.fishid "
            "WHERE (fla.lureid = %u || ff.item = 1) "
            "AND fla.fishid IN(select fg.fishid FROM fishing_group fg WHERE fg.groupid = (select groupid from fishing_catch where zoneid = %u and areaid = %u)) "
            "AND ff.disabled = 0 "
            "GROUP BY ff.fishid";

        int32 ret = Sql_Query(SqlHandle, Query, lureId, zoneId, areaId);
        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            std::vector<fish_t> *fishList = new std::vector<fish_t>();

            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                fish_t fish;
                fish.fishId = Sql_GetUIntData(SqlHandle, 0);
                fish.fishName.insert(0, (const char*)Sql_GetData(SqlHandle, 1));
                fish.minSkill = Sql_GetUIntData(SqlHandle, 2);
                fish.maxSkill = Sql_GetUIntData(SqlHandle, 3);
                fish.size = Sql_GetUIntData(SqlHandle, 4);
                fish.baseDelay = Sql_GetUIntData(SqlHandle, 5);
                fish.baseMove = Sql_GetUIntData(SqlHandle, 6);
                fish.minLength = Sql_GetUIntData(SqlHandle, 7);
                fish.maxLength = Sql_GetUIntData(SqlHandle, 8);
                fish.sizeType = Sql_GetUIntData(SqlHandle, 9);
                fish.waterType = Sql_GetUIntData(SqlHandle, 10);
                fish.log = Sql_GetUIntData(SqlHandle, 11);
                fish.quest = Sql_GetUIntData(SqlHandle, 12);
                fish.flags = Sql_GetUIntData(SqlHandle, 13);
                fish.legendary = Sql_GetUIntData(SqlHandle, 14);
                fish.legendary_flags = Sql_GetUIntData(SqlHandle, 15);
                fish.item = Sql_GetUIntData(SqlHandle, 16);
                fish.maxhook = Sql_GetUIntData(SqlHandle, 17);
                fish.rarity = Sql_GetUIntData(SqlHandle, 18);
                fish.reqKeyItem = Sql_GetUIntData(SqlHandle, 19);
                size_t length = 0;
                char* reqFish = nullptr;
                Sql_GetData(SqlHandle, 20, &reqFish, &length);
                uint8 numFish = (uint8)length / sizeof(uint16);
                fish.reqFish = new std::vector<uint16>();
                for (int i = 0; i < numFish; i++) {
                    uint16 fishid = 0;
                    memcpy(&fishid, &reqFish[i * sizeof(uint16)], sizeof(uint16));
                    fish.reqFish->push_back(fishid);
                }
                
                fish.lurePower = Sql_GetUIntData(SqlHandle, 21);
                fishList->push_back(fish);
            }
            return fishList;
        }
        return nullptr;
    }

    std::vector<fishmob_t> *GetFishingAreaMobs(uint16 ZoneId) {

        const char* Query =
            "SELECT "
            "mobid, "               // 0
            "name, "                // 1
            "level, "               // 2
            "size, "                // 3
            "base_delay, "          // 4
            "base_move, "           // 5
            "log, "                 // 6
            "quest, "               // 7
            "nm, "                  // 8
            "nm_flags, "            // 9
            "rarity, "              // 10
            "min_respawn, "         // 11
            "required_key_item, "   // 12
            "required_lureid, "     // 13
            "areaid "               // 14
            "FROM fishing_mob "
            "WHERE zoneid = %u "
            "AND disabled=0 "
            "ORDER BY mobid ASC";
        int32 ret = Sql_Query(SqlHandle, Query, ZoneId);
        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            std::vector<fishmob_t> *mobList = new std::vector<fishmob_t>();

            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                fishmob_t mob;
                mob.mobId = Sql_GetUIntData(SqlHandle, 0);
                mob.mobName.insert(0, (const char*)Sql_GetData(SqlHandle, 1));
                mob.level = Sql_GetUIntData(SqlHandle, 2);
                mob.size = Sql_GetUIntData(SqlHandle, 3);
                mob.baseDelay = Sql_GetUIntData(SqlHandle, 4);
                mob.baseMove = Sql_GetUIntData(SqlHandle, 5);
                mob.log = Sql_GetUIntData(SqlHandle, 6);
                mob.quest = Sql_GetUIntData(SqlHandle, 7);
                mob.nm = Sql_GetUIntData(SqlHandle, 8);
                mob.nmFlags = Sql_GetUIntData(SqlHandle, 9);
                mob.rarity = Sql_GetUIntData(SqlHandle, 10);
                mob.minRespawn = Sql_GetUIntData(SqlHandle, 11);
                mob.reqKeyItem = Sql_GetUIntData(SqlHandle, 12);
                mob.reqLureId = Sql_GetUIntData(SqlHandle, 13);
                mob.areaId = Sql_GetUIntData(SqlHandle, 14);
                mobList->push_back(mob);
            }
            return mobList;
        }
        return nullptr;
    }

    fishinglure_t *GetLure(uint16 LureID)
    {
        const char* Query =
            "SELECT "
            "lureid, "              // 0
            "name, "                // 1
            "luretype, "            // 2
            "maxhook, "             // 3
            "losable, "             // 4
            "mmm "                  // 5
            "FROM fishing_lure "
            "WHERE lureid = %u ";

        int32 ret = Sql_Query(SqlHandle, Query, LureID);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS && Sql_GetUIntData(SqlHandle, 0) > 0)
        {
            fishinglure_t *lure = new fishinglure_t();
            lure->lureId = Sql_GetUIntData(SqlHandle, 0);
            lure->lureName.insert(0, (const char*)Sql_GetData(SqlHandle, 1));
            lure->luretype = Sql_GetUIntData(SqlHandle, 2);
            lure->maxhook = Sql_GetUIntData(SqlHandle, 3);
            lure->losable = Sql_GetUIntData(SqlHandle, 4);
            lure->isMMM = Sql_GetUIntData(SqlHandle, 5);
            return lure;
        }
        return nullptr;
    }

    fishingrod_t *GetRod(uint16 RodID)
    {
        const char* Query =
            "SELECT "
            "rodid, "               // 0
            "name, "                // 1
            "material, "            // 2
            "size_type, "           // 3
            "durability, "          // 4
            "fish_attack, "         // 5
            "lgd_bonus_attack, "    // 6
            "miss_regen, "          // 7
            "lgd_miss_regen, "      // 8
            "fish_time, "           // 9
            "lgd_bonus_time, "      // 10
            "sm_delay_Bonus, "      // 11
            "sm_move_bonus, "       // 12
            "lg_delay_bonus, "      // 13
            "lg_move_bonus, "       // 14
            "multiplier, "          // 15
            "breakable, "           // 16
            "broken_rodid, "        // 17
            "mmm, "                 // 18
            "flags "                // 19
            "FROM fishing_rod "
            "WHERE rodid = %u ";

        int32 ret = Sql_Query(SqlHandle, Query, RodID);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS && Sql_GetUIntData(SqlHandle, 0) > 0)
        {
            fishingrod_t *rod = new fishingrod_t();
            rod->rodId = Sql_GetUIntData(SqlHandle, 0);
            rod->rodName.insert(0, (const char*)Sql_GetData(SqlHandle, 1));
            rod->material = Sql_GetUIntData(SqlHandle, 2);
            rod->sizeType = Sql_GetUIntData(SqlHandle, 3);
            rod->durability = Sql_GetUIntData(SqlHandle, 4);
            rod->fishAttack = Sql_GetUIntData(SqlHandle, 5);
            rod->lgdBonusAtk = Sql_GetUIntData(SqlHandle, 6);
            rod->missRegen = Sql_GetUIntData(SqlHandle, 7);
            rod->lgdMissRegen = Sql_GetUIntData(SqlHandle, 8);
            rod->fishTime = Sql_GetUIntData(SqlHandle, 9);
            rod->lgdBonusTime = Sql_GetUIntData(SqlHandle, 10);
            rod->smDelayBonus = Sql_GetUIntData(SqlHandle, 11);
            rod->smMoveBonus = Sql_GetUIntData(SqlHandle, 12);
            rod->lgDelayBonus = Sql_GetUIntData(SqlHandle, 13);
            rod->lgMoveBonus = Sql_GetUIntData(SqlHandle, 14);
            rod->multiplier = Sql_GetUIntData(SqlHandle, 15);
            rod->breakable = Sql_GetUIntData(SqlHandle, 16);
            rod->brokenRodId = Sql_GetUIntData(SqlHandle, 17);
            rod->isMMM = Sql_GetUIntData(SqlHandle, 18);
            rod->flags = Sql_GetUIntData(SqlHandle, 19);
            return rod;
        }
        return nullptr;
    }

    int32 LoseCatch(CCharEntity* PChar, uint8 FailType)
    {
        uint16 MessageOffset = GetMessageOffset(PChar->getZone());
        PChar->updatemask |= UPDATE_HP;
        switch (FailType) {
        case FISHINGFAILTYPE_LINESNAP:
            PChar->animation = ANIMATION_NEW_FISHING_LINE_BREAK;
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_LINEBREAK));
            break;
        case FISHINGFAILTYPE_RODBREAK:
            PChar->animation = ANIMATION_NEW_FISHING_ROD_BREAK;
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_RODBREAK));
            break;
        case FISHINGFAILTYPE_RODBREAK_TOOBIG:
            PChar->animation = ANIMATION_NEW_FISHING_ROD_BREAK;
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_RODBREAK_TOOBIG));
            break;
        case FISHINGFAILTYPE_RODBREAK_TOOHEAVY:
            PChar->animation = ANIMATION_NEW_FISHING_ROD_BREAK;
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_RODBREAK_TOOHEAVY));
            break;
        case FISHINGFAILTYPE_LOST_TOOSMALL:
            PChar->animation = ANIMATION_NEW_FISHING_STOP;
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_LOST_TOOSMALL));
            break;
        case FISHINGFAILTYPE_LOST_LOWSKILL:
            PChar->animation = ANIMATION_NEW_FISHING_STOP;
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_LOST_LOWSKILL));
            break;
        case FISHINGFAILTYPE_LOST_TOOBIG:
            PChar->animation = ANIMATION_NEW_FISHING_STOP;
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_LOST_TOOBIG));
            break;
        case FISHINGFAILTYPE_LOST:
        case FISHINGFAILTYPE_NONE:
        default:
            PChar->animation = ANIMATION_NEW_FISHING_STOP;
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_LOST));
            break;
        }
        return 1;
    }

    int32 CatchNothing(CCharEntity* PChar, uint8 FailType)
    {
        uint16 MessageOffset = GetMessageOffset(PChar->getZone());
        PChar->animation = ANIMATION_NEW_FISHING_STOP;
        PChar->updatemask |= UPDATE_HP;
        switch (FailType) {
        case FISHINGFAILTYPE_NONE:
        default:
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_NOCATCH));
            break;
        }
        return 1;
    }

    int32 CatchFish(CCharEntity* PChar, uint16 FishID, bool BigFish, uint16 length, uint16 weight, uint8 Count = 1)
    {
        uint16 MessageOffset = GetMessageOffset(PChar->getZone());
        PChar->animation = ANIMATION_NEW_FISHING_CAUGHT;
        PChar->updatemask |= UPDATE_HP;

        if (PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() != 0) {
            CItemFish *Fish = (CItemFish*)itemutils::GetItem(FishID);
            if (Fish == nullptr) {
                ShowError("Invalid ItemID %i for fished item\n", FishID);
                PChar->animation = ANIMATION_FISHING_STOP;
                PChar->updatemask |= UPDATE_HP;
                PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_LOST));
                return 0;
            }
            if (length > 1) {
                Fish->SetLength(length);
                Fish->SetWeight(weight);
            }
            Fish->setQuantity(Count);
            charutils::AddItem(PChar, LOC_INVENTORY, Fish);

            if (Count > 1) {
                PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, new CCaughtFishPacket(PChar, FishID, MessageOffset + FISHMESSAGEOFFSET_CATCH_MULTI, Count));
            }
            else {
                PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, new CCaughtFishPacket(PChar, FishID, MessageOffset + FISHMESSAGEOFFSET_CATCH, Count));
            }
            return 1;
        }
        else {
            PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, new CCaughtFishPacket(PChar, FishID, MessageOffset + FISHMESSAGEOFFSET_CATCH_INV_FULL, Count));
        }
        return 0;
    }

    int32 CatchItem(CCharEntity* PChar, uint16 ItemID, uint8 Count = 1)
    {
        uint16 MessageOffset = GetMessageOffset(PChar->getZone());
        PChar->animation = ANIMATION_NEW_FISHING_CAUGHT;
        PChar->updatemask |= UPDATE_HP;

        if (PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() != 0) {
            CItem *Item = (CItem*)itemutils::GetItem(ItemID);
            if (Item == nullptr) {
                ShowError("Invalid ItemID %i for fished item\n", ItemID);
                PChar->animation = ANIMATION_FISHING_STOP;
                PChar->updatemask |= UPDATE_HP;
                PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_LOST));
                return 0;
            }
            charutils::AddItem(PChar, LOC_INVENTORY, ItemID, Count);
            if (Count > 1) {
                PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, new CCaughtFishPacket(PChar, ItemID, MessageOffset + FISHMESSAGEOFFSET_CATCH_MULTI, Count));
            }
            else {
                PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, new CCaughtFishPacket(PChar, ItemID, MessageOffset + FISHMESSAGEOFFSET_CATCH, Count));
            }
            return 1;
        }
        else {
            PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, new CCaughtFishPacket(PChar, ItemID, MessageOffset + FISHMESSAGEOFFSET_CATCH_INV_FULL, Count));
        }
        return 0;
    }


    int32 CatchMonster(CCharEntity* PChar, uint32 MobID)
    {
        uint16 MessageOffset = GetMessageOffset(PChar->getZone());

        CMobEntity* PMob = (CMobEntity*)zoneutils::GetEntity(MobID, TYPE_MOB);
        if (PMob == nullptr)
        {
            ShowError("Invalid MobID %i for fished monster\n", MobID);
            PChar->animation = ANIMATION_FISHING_STOP;
            PChar->updatemask |= UPDATE_HP;
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_LOST));
            return 0;
        }

        PChar->animation = ANIMATION_NEW_FISHING_MONSTER;
        PChar->updatemask |= UPDATE_HP;

        PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, new CCaughtMonsterPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_MONSTER));
        position_t p = PChar->loc.p;
        position_t m;
        double Radians = p.rotation * M_PI / 128;
        m.x = p.x - 2.0f * (float)cos(Radians);
        m.y = p.y;
        m.z = p.z + 2.0f * (float)sin(Radians);
        m.rotation = getangle(m, p);
        PMob->m_SpawnPoint = m;
        PMob->Spawn();
        PMob->SetDespawnTime(std::chrono::seconds(180));
        PMob->SetLocalVar("hooked", 0);
        if (!PChar->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK))
        {
            PMob->PEnmityContainer->AddBaseEnmity(PChar);
            battleutils::ClaimMob((CMobEntity*)PMob, (CBattleEntity*)PChar);
        }

        return 1;
    }

    int32 CatchChest(CCharEntity* PChar, uint32 NpcID)
    {
        uint16 MessageOffset = GetMessageOffset(PChar->getZone());

        // @todo: get chest npc (i.e. jade etui)
        CNpcEntity* Chest = (CNpcEntity*)zoneutils::GetEntity(NpcID, TYPE_NPC);

        if (Chest == nullptr)
        {
            ShowError("Invalid NpcID %i for fished chest\n", NpcID);
            PChar->animation = ANIMATION_FISHING_STOP;
            PChar->updatemask |= UPDATE_HP;
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_LOST));
            return 0;
        }

        PChar->animation = ANIMATION_NEW_FISHING_CAUGHT;
        PChar->updatemask |= UPDATE_HP;

        PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, new CCaughtMonsterPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_CATCH_CHEST));
        position_t p = PChar->loc.p;
        position_t m;
        double Radians = p.rotation * M_PI / 128;
        m.x = p.x - 2.0f * (float)cos(Radians);
        m.y = p.y;
        m.z = p.z + 2.0f * (float)sin(Radians);
        m.rotation = getangle(m, p);

        // @todo: spawnchest
        Chest->loc.p = m;
        Chest->status = STATUS_NORMAL;
        zoneutils::GetZone(PChar->getZone())->PushPacket(Chest, CHAR_INRANGE, new CEntityUpdatePacket(Chest, ENTITY_UPDATE, UPDATE_COMBAT));

        return 1;
    }

    void SendSenseMessage(CCharEntity* PChar, fishresponse_t* response)
    {
        uint16 MessageOffset = GetMessageOffset(PChar->getZone());
        switch (response->sense)
        {
        case FISHINGSENSETYPE_GOOD:
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_GOOD_FEELING));
            break;
        case FISHINGSENSETYPE_BAD:
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_BAD_FEELING));
            break;
        case FISHINGSENSETYPE_TERRIBLE:
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_TERRIBLE_FEELING));
            break;
        case FISHINGSENSETYPE_NOSKILL_FEELING:
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_NOSKILL_FEELING));
            break;
        case FISHINGSENSETYPE_NOSKILL_SURE_FEELING:
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_NOSKILL_SURE_FEELING));
            break;
        case FISHINGSENSETYPE_NOSKILL_POSITIVEFEELING:
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_NOSKILL_POSITIVE_FEELING));
            break;
        case FISHINGSENSETYPE_KEEN_ANGLERS_SENSE:
            PChar->pushPacket(new CMessageSpecialPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_KEEN_ANGLERS_SENSE, response->catchid, 3, 3, 3));
            break;
        case FISHINGSENSETYPE_EPIC_CATCH:
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_EPIC_CATCH));
            break;
        }
    }

    void SendHookResponse(CCharEntity* PChar, fishresponse_t* response, bool cancelOnMobLoadFailure)
    {
        uint16 MessageOffset = GetMessageOffset(PChar->getZone());

        switch (response->catchtype)
        {
        case FISHINGCATCHTYPE_SMALLFISH:
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_HOOKED_SMALL_FISH));
            break;
        case FISHINGCATCHTYPE_BIGFISH:
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_HOOKED_LARGE_FISH));
            break;
        case FISHINGCATCHTYPE_ITEM:
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_HOOKED_ITEM));
            break;
        case FISHINGCATCHTYPE_MOB:
            CMobEntity* PMob = (CMobEntity*)zoneutils::GetEntity(PChar->hookedFish->catchid, TYPE_MOB);
            if (CanFishMob(PMob)) {
                PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_HOOKED_MONSTER));
            }
            else {
                if (cancelOnMobLoadFailure) {
                    CatchNothing(PChar, FISHINGFAILTYPE_NONE);
                }
            }
            break;
        }
    }

    // Generate a non-cumulative normal distribution value
    static double NormalDist(double x, double mean, double standard_dev)
    {
        return exp(-0.5 * log(2 * M_PI) - log(standard_dev) - pow(x - mean, 2) / (2 * standard_dev * standard_dev));
    }

    void FishingSkillup(CCharEntity* PChar, uint8 catchLevel, uint8 successType)
    {
        if (successType == FISHINGSUCCESSTYPE_NONE)
            return;

        uint8  skillRank = PChar->RealSkills.rank[SKILL_FISHING];
        uint16 maxSkill = (skillRank + 1) * 100;
        int32  charSkill = PChar->RealSkills.skill[SKILL_FISHING];
        int32  charSkillLevel = (uint32)std::floor(PChar->RealSkills.skill[SKILL_FISHING] / 10);
        uint8 levelDifference = 0;
        int maxSkillAmount = 1;
        CItemWeapon* Rod = (CItemWeapon*)PChar->getEquip(SLOT_RANGED);

        if (catchLevel > charSkillLevel) {
            levelDifference = catchLevel - charSkillLevel;
        }

        // No skillup if fish level not between char level and 50 levels higher
        if (catchLevel <= charSkillLevel || (levelDifference > 50)) {
            return;
        }

        int skillRoll = 90;
        int maxChance = 0;
        int bonusChanceRoll = 8;

        // Lu shang rod under level 50 penalty
        if (Rod != nullptr && charSkillLevel < 50 && Rod->getID() == LU_SHANG_ROD_ID)
            skillRoll += 20;

        // Generate a normal distribution favoring fish 10 levels higher in skill with 5 levels of deviation on either side
        double normDist = NormalDist(levelDifference, 11, 5);

        int distMod = (int)std::floor(normDist*200);
        int lowerLevelBonus = (int)std::floor((100 - charSkillLevel) / 10);
        int skillLevelPenalty = (int)std::floor(charSkillLevel / 10);

        // Minimum 4% chance
        maxChance = std::max(4, distMod + lowerLevelBonus - skillLevelPenalty);

        // Moon phase skillup modifiers
        uint8 phase = CVanaTime::getInstance()->getMoonPhase();
        uint8 moonDirection = CVanaTime::getInstance()->getMoonDirection();
        switch (moonDirection)
        {
        case 0: // None
            if (phase == 0) {
                skillRoll -= 20;
                bonusChanceRoll -= 3;
            } else if (phase == 100) {
                skillRoll += 10;
                bonusChanceRoll += 3;
            }
            break;
        case 1: // Waning (decending)
            if (phase <= 10 && phase >= 0) {
                skillRoll -= 15;
                bonusChanceRoll -= 2;
            } else if (phase >= 95 && phase <= 100) {
                skillRoll += 5;
                bonusChanceRoll += 2;
            }
            break;
        case 2: // Waxing (increasing)
            if (phase >= 0 && phase <= 5) {
                skillRoll -= 10;
                bonusChanceRoll -= 1;
            }
            else if (phase >= 90 && phase <= 100) {
                bonusChanceRoll += 1;
            }
            break;
        }

        // Not in City bonus
        if (zoneutils::GetZone(PChar->getZone())->GetType() > ZONETYPE_CITY) {
            skillRoll -= 10;
        }

        if (charSkillLevel < 50) {
            skillRoll -= (20 - (uint8)std::floor(charSkillLevel / 3));
        }

        // Max skill amount increases as level difference gets higher
        const int skillAmountAdd = 1 + (int)std::floor(levelDifference / 5);
        maxSkillAmount = std::min(skillAmountAdd, 3);

        if (tpzrand::GetRandomNumber(1,skillRoll) < maxChance) {
            int32  skillAmount = 1;

            // Bonus points 
            if (tpzrand::GetRandomNumber(bonusChanceRoll) == 1) {
                skillAmount = tpzrand::GetRandomNumber(1, maxSkillAmount);
            }
                        
            if ((skillAmount + charSkill) > maxSkill)
            {
                skillAmount = maxSkill - charSkill;
            }

            if (skillAmount > 0) {
                PChar->RealSkills.skill[SKILL_FISHING] += skillAmount;
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, SKILL_FISHING, skillAmount, 38));

                if ((charSkill / 10) < (charSkill + skillAmount) / 10)
                {
                    PChar->WorkingSkills.skill[SKILL_FISHING] += 0x20;

                    PChar->pushPacket(new CCharSkillsPacket(PChar));
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, SKILL_FISHING, (charSkill + skillAmount) / 10, 53));
                }

                charutils::SaveCharSkills(PChar, SKILL_FISHING);
            }
        }
    }


    /************************************************************************
    *																		*
    *						        FISHING    								*
    *																		*
    ************************************************************************/

    void StartFishing(CCharEntity* PChar)
    {
        uint16 MessageOffset = GetMessageOffset(PChar->getZone());
        CItemWeapon* Rod = nullptr;
        CItemWeapon* Bait = nullptr;
        uint8 FishingAreaID = 0;

        if (charutils::GetCharVar(PChar, "FishingDenied") == 1) {
            charutils::AddVar(PChar, "FishingDeniedAttempts", 1);
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_CANNOTFISH_TIME));
            PChar->pushPacket(new CReleasePacket(PChar, RELEASE_FISHING));
            return;
        }


        uint32 vanaTime = CVanaTime::getInstance()->getVanaTime();
        if (PChar->nextFishTime > vanaTime) {
            PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_CANNOTFISH_MOMENT));
            PChar->pushPacket(new CReleasePacket(PChar, RELEASE_FISHING));
            return;
        }
        else {
            PChar->lastCastTime = vanaTime;
            PChar->nextFishTime = PChar->lastCastTime + 5;
        }

        // If not able to pull the fishing message offset for the current zone, can't fish
        if (MessageOffset == 0)
        {
            ShowWarning(CL_YELLOW"Player wants to fish in %s\n" CL_RESET, PChar->loc.zone->GetName());
            PChar->pushPacket(new CReleasePacket(PChar, RELEASE_FISHING));
            return;
        }

        fishingarea_t *Area = GetFishingArea(PChar);

        if (Area != nullptr) {
            FishingAreaID = Area->areaId;
            delete Area;
            Area = nullptr;
        }

        if (FishingAreaID > 0) {

            PChar->fishingToken = 1 + tpzrand::GetRandomNumber(999999);

            if (PChar->hookedFish == nullptr)
                PChar->hookedFish = new fishresponse_t();

            PChar->hookedFish->caught = false;
            PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_NONE;

            // If in the middle of something else, can't fish
            if (PChar->animation != ANIMATION_NONE)
            {
                PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_CANNOTFISH_MOMENT));
                PChar->pushPacket(new CMessageSystemPacket(0, 0, 142));
                PChar->pushPacket(new CReleasePacket(PChar, RELEASE_FISHING));
                return;
            }

            Rod = (CItemWeapon*)PChar->getEquip(SLOT_RANGED);
            Bait = (CItemWeapon*)PChar->getEquip(SLOT_AMMO);

            // If no rod, then can't fish
            if ((Rod == nullptr) ||
                !(Rod->isType(ITEM_WEAPON)) ||
                (Rod->getSkillType() != SKILL_FISHING))
            {
                PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_NOROD));
                PChar->pushPacket(new CReleasePacket(PChar, RELEASE_FISHING));
                return;
            }

            // If no bait, then can't fish
            if ((Bait == nullptr) ||
                !(Bait->isType(ITEM_WEAPON)) ||
                (Bait->getSkillType() != SKILL_FISHING))
            {
                PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_NOBAIT));
                PChar->pushPacket(new CReleasePacket(PChar, RELEASE_FISHING));
                return;
            }

            // Call LUA callback
            luautils::OnFishingStart(PChar, Rod->getID(), Bait->getID(), FishingAreaID);

            charutils::AddVar(PChar, "FishingStarts", 1);

            // Start fishing animation
            PChar->animation = ANIMATION_NEW_FISHING_START;
            PChar->updatemask |= UPDATE_HP;

            PChar->pushPacket(new CCharUpdatePacket(PChar));
            PChar->pushPacket(new CCharSyncPacket(PChar));
        }
        else {
            PChar->pushPacket(new CMessageSystemPacket(0, 0, 142));
            PChar->pushPacket(new CReleasePacket(PChar, RELEASE_FISHING));
            return;
        }
        
    }


    void ReelInCatch(CCharEntity* PChar)
    {
        if (PChar->hookedFish != nullptr) {
            switch (PChar->hookedFish->catchtype)
            {
            case FISHINGCATCHTYPE_NONE:
                charutils::AddVar(PChar, "FishingCaughtNothing", 1);
                PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_NONE;
                CatchNothing(PChar, FISHINGFAILTYPE_NONE);
                break;
            case FISHINGCATCHTYPE_SMALLFISH:
                charutils::AddVar(PChar, "FishingCaughtSmallFish", 1);
                PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_CATCHSMALL;
                CatchFish(PChar, PChar->hookedFish->catchid, false, 0, 0, PChar->hookedFish->count);
                break;
            case FISHINGCATCHTYPE_BIGFISH:
                charutils::AddVar(PChar, "FishingCaughtLargeFish", 1);
                PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_CATCHLARGE;
                CatchFish(PChar, PChar->hookedFish->catchid, true, PChar->hookedFish->length, PChar->hookedFish->weight, PChar->hookedFish->count);
                break;
            case FISHINGCATCHTYPE_ITEM:
                charutils::AddVar(PChar, "FishingCaughtItem", 1);
                PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_CATCHITEM;
                CatchItem(PChar, PChar->hookedFish->catchid, PChar->hookedFish->count);
                break;
            case FISHINGCATCHTYPE_MOB:
                charutils::AddVar(PChar, "FishingCaughtMob", 1);
                PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_CATCHMOB;
                CatchMonster(PChar, PChar->hookedFish->catchid);
                break;
            case FISHINGCATCHTYPE_CHEST:
                PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_CATCHCHEST;
                CatchChest(PChar, PChar->hookedFish->catchid);
                break;
            }
        }
        AddFishingLog(PChar);
    }

    uint8 UnhookMob(CCharEntity* PChar, bool lost) {
        if (PChar->hookedFish != nullptr) {
            CMobEntity* PMob = (CMobEntity*)zoneutils::GetEntity(PChar->hookedFish->catchid, TYPE_MOB);
            if (PMob != nullptr) {
                PMob->SetLocalVar("hooked", 0);
                if (lost && PChar->hookedFish->nm && PChar->hookedFish->nmFlags & FISHINGNM_RESET_RESPAWN_ON_FAIL) {
                    PMob->SetLocalVar("lastTOD", (uint32)time(nullptr));
                }
            }
        }
        return 0;
    }

    void FishingAction(CCharEntity* PChar, FISHACTION action, uint16 stamina, uint32 special)
    {
        uint16 MessageOffset = GetMessageOffset(PChar->getZone());
        uint32 vanaTime = CVanaTime::getInstance()->getVanaTime();

        if (charutils::GetCharVar(PChar, "FishingDenied") == 1) {
            CatchNothing(PChar, FISHINGFAILTYPE_NONE);
            PChar->fishingToken = 0;
            PChar->animation = ANIMATION_NONE;
            PChar->updatemask |= UPDATE_HP;
            PChar->pushPacket(new CCharUpdatePacket(PChar));
            PChar->pushPacket(new CCharSyncPacket(PChar));
            return;
        }

        luautils::OnFishingAction(PChar, action, stamina, special);

        switch (action)
        {
            case FISHACTION_CHECK:
            {
                if (vanaTime < PChar->lastCastTime + 10) {
                    CatchNothing(PChar, FISHINGFAILTYPE_NONE);
                    return;
                }

                fishingarea_t *fishingArea = GetFishingArea(PChar);
                fishresponse_t* response = nullptr;

                if (PChar->hookedFish != nullptr) {
                    delete PChar->hookedFish;
                    PChar->hookedFish = nullptr;
                }

                if (fishingArea != nullptr) {

                    CItemWeapon* Rod = nullptr;
                    CItemWeapon* Bait = nullptr;

                    Rod = (CItemWeapon*)PChar->getEquip(SLOT_RANGED);
                    Bait = (CItemWeapon*)PChar->getEquip(SLOT_AMMO);

                    if (Rod != nullptr && Bait != nullptr) {
                        std::vector<fish_t> *FishList = GetFishingAreaFish(PChar->getZone(),fishingArea->areaId,Bait->getID());
                        std::vector<fishmob_t> *MobList = GetFishingAreaMobs(PChar->getZone());
                        fishingrod_t *FishingRod = GetRod(Rod->getID());
                        fishinglure_t *FishingLure = GetLure(Bait->getID());
                          
                        if (FishingRod != nullptr && FishingLure != nullptr) {
                            response = luautils::OnFishingCheck(PChar, FishingRod, FishList, MobList, fishingArea->areaId, fishingArea->areaName, FishingLure, fishingArea->difficulty);
                            PChar->hookedFish = response;
                        }

                        if (FishList != nullptr) {
                            for (uint8 i = 0; i < FishList->size(); i++) {
                                if (FishList->at(i).reqFish != nullptr) {
                                    FishList->at(i).reqFish->clear();
                                    delete FishList->at(i).reqFish;
                                    FishList->at(i).reqFish = nullptr;
                                }
                            }
                            FishList->clear();
                            delete FishList;
                            FishList = nullptr;
                        }
                        if (MobList != nullptr) {
                            MobList->clear();
                            delete MobList;
                            MobList = nullptr;
                        }
                        if (FishingRod != nullptr) {
                            delete FishingRod;
                            FishingRod = nullptr;
                        }
                        if (FishingLure != nullptr) {
                            delete FishingLure;
                            FishingLure = nullptr;
                        }

                    }

                }
                if (response->fishingToken == 0 || response->fishingToken != PChar->fishingToken)
                {
                    charutils::SetVar(PChar, "FishingDenied", 1);
                    charutils::SetVar(PChar, "FishingBot", 1);
                    RodBreak(PChar);
                    CatchNothing(PChar, FISHINGFAILTYPE_NONE);
                    PChar->status = STATUS_SHUTDOWN;
                    charutils::SendToZone(PChar, 1, 0);
                }
                else if (fishingArea != nullptr && response != nullptr && response->caught && response->catchtype > 0 && response->catchid > 0)
                {                    
                    // send catch message
                    SendHookResponse(PChar, response, true);
  
                    // send then response sense message
                    SendSenseMessage(PChar, response);

                    //play the sweating animation
                    PChar->pushPacket(new CEntityAnimationPacket(PChar, "hitl"));
                    
                    //send the fishing packet
                    PChar->animation = ANIMATION_NEW_FISHING_FISH;
                    PChar->updatemask |= UPDATE_HP;
                    PChar->pushPacket(new CFishingPacket(response->stamina, response->regen, response->response, response->attackdmg, response->delay, response->heal, response->timelimit, response->hooksense, response->special));
                }
                else
                {
                    CatchNothing(PChar, FISHINGFAILTYPE_NONE);
                }
                if (fishingArea != nullptr) {
                    delete fishingArea;
                    fishingArea = nullptr;
                }
            }
            break;

            case FISHACTION_FINISH:
            {
                if (stamina <= 4)
                {
                    CItemWeapon* Rod = nullptr;

                    Rod = (CItemWeapon*)PChar->getEquip(SLOT_RANGED);
                    fishingrod_t *FishingRod = GetRod(Rod->getID());

                    luautils::OnFishingCatch(PChar, PChar->hookedFish->catchtype, PChar->hookedFish->catchid);

                    catchresponse_t* response = luautils::OnFishingReelIn(PChar, PChar->hookedFish, FishingRod);
                    if (response->fishingToken == 0 || response->fishingToken != PChar->fishingToken) {
                        charutils::SetVar(PChar, "FishingDenied", 1);
                        charutils::SetVar(PChar, "FishingBot", 1);
                        RodBreak(PChar);
                        PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_RODBREAK;
                        PChar->status = STATUS_SHUTDOWN;
                        charutils::SendToZone(PChar, 1, 0);
                    } else if (response->caught) {
                        PChar->fishingToken = 0;
                        ReelInCatch(PChar);
                        LureLoss(PChar, false, true);
                        if (Rod->getID() == 17386 && tpzrand::GetRandomNumber(1000) == 500) {
                            EE(PChar, Rod);
                        }
                    }
                    else {
                        if (response->linebreak) {
                            charutils::AddVar(PChar, "FishingLineBreaks", 1);
                            LureLoss(PChar, true, true);
                            PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_LINEBREAK;
                        }
                        else if (response->rodbreak) {
                            charutils::AddVar(PChar, "FishingRodBreaks", 1);
                            RodBreak(PChar);
                            PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_RODBREAK;
                        }
                        LoseCatch(PChar, response->failReason);                        
                        UnhookMob(PChar, !response->caught);
                    }
                    if (FishingRod != nullptr) {
                        delete FishingRod;
                        FishingRod = nullptr;
                    }
                    if (response != nullptr) {
                        delete response;
                        response = nullptr;
                    }

                }
                else if (stamina <= 0x14)
                {
                    // you lost the catch due to lack of skill
                    // lose bait but keep lure
                    charutils::AddVar(PChar, "FishingLineBreaks", 1);
                    PChar->animation = ANIMATION_NEW_FISHING_LINE_BREAK;
                    PChar->updatemask |= UPDATE_HP;
                    LureLoss(PChar, false, true);
                    PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_LOST_LOWSKILL));
                    if (PChar->hookedFish) {
                        PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_NONE;
                    }
                }
                else if (stamina <= 0x64)
                {
                    // message: "Your line breaks!"
                    charutils::AddVar(PChar, "FishingLineBreaks", 1);
                    PChar->animation = ANIMATION_NEW_FISHING_LINE_BREAK;
                    PChar->updatemask |= UPDATE_HP;
                    LureLoss(PChar, true, true);
                    PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_LINEBREAK));
                    if (PChar->hookedFish) {
                        PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_NONE;
                    }
                }
                else if (stamina <= 0x100)
                {
                    // message: "You give up!"
                    charutils::AddVar(PChar, "FishingGiveUps", 1);
                    PChar->animation = ANIMATION_NEW_FISHING_STOP;
                    PChar->updatemask |= UPDATE_HP;

                    if (PChar->hookedFish && PChar->hookedFish->caught &&
                        LureLoss(PChar, false, true))
                    {
                        PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_GIVEUP_BAITLOSS));
                        PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_NONE;
                    }
                    else if (PChar->hookedFish && !PChar->hookedFish->caught) {
                        PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_GIVEUP));
                        PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_NONE;
                    }
                }
                else
                {
                    // message: "You lost your catch!"
                    charutils::AddVar(PChar, "FishingTimeouts", 1);
                    PChar->animation = ANIMATION_NEW_FISHING_STOP;
                    PChar->updatemask |= UPDATE_HP;

                    LureLoss(PChar, false, true);
                    PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_LOST));
                    if (PChar->hookedFish) {
                        PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_NONE;
                    }
                }
            }
            break;

            case FISHACTION_WARNING:
            {
                // message: "You don't know how much longer you can keep this one on the line..."

                PChar->pushPacket(new CMessageTextPacket(PChar, MessageOffset + FISHMESSAGEOFFSET_WARNING));
                return;
            }
            break;

            default:
            case FISHACTION_END:
            {
                luautils::OnFishingEnd(PChar);

                if (PChar->hookedFish != nullptr) {
                    UnhookMob(PChar, false);
                    
                    // No skillups for items or mobs.
                    if (PChar->hookedFish->catchtype == FISHINGCATCHTYPE_SMALLFISH || PChar->hookedFish->catchtype == FISHINGCATCHTYPE_BIGFISH)
                    {
                        uint16 skillUpChances = 1 + PChar->getMod(Mod::PELICAN_RING_EFFECT);

                        for (int i = 0; i < skillUpChances; i++) {
                            FishingSkillup(PChar, PChar->hookedFish->catchlevel, PChar->hookedFish->successtype);
                        }
                    }

                    delete PChar->hookedFish;
                    PChar->hookedFish = nullptr;
                }

                PChar->animation = ANIMATION_NONE;
                PChar->updatemask |= UPDATE_HP;
            }
            break;
        }

        PChar->pushPacket(new CCharUpdatePacket(PChar));
        PChar->pushPacket(new CCharSyncPacket(PChar));
    }



} // namespace fishingutils
