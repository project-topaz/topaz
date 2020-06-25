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

  This file is part of DarkStar-server source code.

===========================================================================
*/

#ifndef _FISHINGUTILS_H
#define _FISHINGUTILS_H

#include "../../common/cbasetypes.h"
#include <vector>

const uint32 LU_SHANG_ROD_ID = 17386;

struct fishresponse_t  {
    bool caught;                // Did we catch anything
    uint8 areaid;               // Area caught in
    uint32 catchid;             // ID of fish/item/monster
    uint8 catchtype;            // fish/item/monster
    uint8 catchlevel;           // level of fish
    uint8 catchsize;            // size of fish
    uint8 catchsizeType;        // sizeType of fish - small/large/legendary
    uint8 legendary;            // is fish legendary?
    uint8 count;                // how many fish
    uint16 stamina;             // fish stamina/maxhp
    uint16 delay;               // arrow mini-game delay
    uint16 regen;               // how fast fish regens - default 128
    uint16 response;            // fish movement - multiplied by 20
    uint16 attackdmg;           // how much damage a successful arrow causes
    uint16 heal;                // how much fish heals from wrong arrows, drops 30% on discernment/critical bite
    uint16 timelimit;           // how much time you have to catch fish - multiplied by 60
    uint8 sense;                // changes: message received/music/animation
    uint8 hooksense;            // determines which animations/music to play
    uint32 special;             // % chance of getting gold arrows/critical attack
    uint8 successtype;          // Successful hooking type
    uint16 length;              // length of fish
    uint16 weight;              // weight of fish
    uint8 loseChance;           // chance of losing
    uint8 breakChance;          // chance of break
    uint8 snapChance;           // chance of snap
    bool nm;                    // is this an NM
    uint32 nmFlags;             // if NM, it's flags
    uint32 fishingToken;        // fishing token
};

struct catchresponse_t {
    bool caught;                // Were we able to reel in?
    bool rodbreak;              // Did our Rod break?
    bool linebreak;             // Did our Line break?
    uint8 failReason;           // Why did either happen?
    uint32 fishingToken;        // fishing token
};

struct fish_t {
    uint32 fishId;              // Fish ID
    string_t fishName;          // Fish Name
    uint8 minSkill;             // Minimum hook skill level
    uint8 maxSkill;             // Maximum hook skill level
    uint8 size;                 // 'Size' of fish, used for most hook/rod calculations
    uint8 baseDelay;            // base hook arrow delay
    uint8 baseMove;             // base hook movement
    uint16 minLength;           // minimum fish length (in lms)
    uint16 maxLength;           // maximum fish length (in lms)
    uint8 sizeType;             // small/large
    uint8 waterType;            // fresh/sea
    uint8 log;                  // quest/mission log
    uint16 quest;               // quest/mission id
    uint32 flags;               // fish flags (half size, tropical, bottom dweller)
    uint8 legendary;            // is this a legendary fish? (affects certain rod calcs)
    uint32 legendary_flags;     // legendary flags (half fish time)
    uint8 item;                 // item/fish
    uint8 maxhook;              // maximum that can be hooked (with sabiki rig)
    uint16 rarity;              // [0-1000] : 0 = not rare, 1 = rarest, 1000 = most common
    uint16 reqKeyItem;          // required key item
    std::vector<uint16>* reqFish; // list of required catches
    uint16 lurePower;           // how strong players current lure attracts fish
};

struct fishmob_t {
    uint32 mobId;               // Monster ID
    string_t mobName;           // Monster Name
    uint8 log;                  // Log ID
    uint8 quest;                // Quest ID
    bool nm;                    // Notorious Monster, no need to set for quest monsters
    uint32 nmFlags;             // Notorious Monster flags
    uint8 areaId;               // Can this mob only be fished up from a certain area? i.e. PLD NM
    uint16 rarity;              // [0-1000] : 0 = not rare, 1 = rarest, 1000 = most common
    uint16 minRespawn;          // minimum amount of time before mob can be hooked again
    uint8 level;                // level of monster (seem to be intervals of 10)
    uint8 size;                 // hook size of monster
    uint8 baseDelay;            // base hook arrow delay
    uint8 baseMove;             // base hook movement
    uint16 reqKeyItem;          // required key item
    uint32 reqLureId;           // required bait
};

struct areavector_t {
    float x;
    float y;
    float z;
};

struct boundarydata_t {
    int count;
    areavector_t *bounds;
};

struct fishingarea_t {
    uint32 zoneId;              // Zone ID
    uint32 areaId;              // Area ID
    string_t areaName;          // Area Name
    uint8 areatype;             // What type of bounds checking is done
    uint8 numBounds;            // Number of boundary vectors
    uint8 height;               // Height of bounds
    areavector_t center;        // Center point for radius bound type
    uint8 radius;               // Radius for radial boundary type
    uint8 difficulty;           // Area zone hook difficulty
};

struct fishinglure_t {
    uint32 lureId;              // Lure ID
    string_t lureName;          // Lure Name
    uint8 luretype;             // Type of lure (stackable bait/lure)
    uint8 maxhook;              // Maximum number of fish lure can hook (sabiki rig can hook up to 3 of certain fish)
    uint32 flags;               // Lure Flags (sinking, item bonus)
    bool losable;               // Can the lure be lost?
    bool isMMM;                 // Is Moblin Maze Monger bait? (probably not special, haven't tested)
};

struct fishingrod_t {
    uint32 rodId;               // Rod ID
    string_t rodName;           // Rod Name
    uint8 material;             // Rod Material (wood/synthetic/legendary)
    uint8 sizeType;             // small/large
    uint32 flags;               // Rod Flags (large bonus/small penalty)
    uint8 durability;           // Rod Durability on scale of 10-100
    uint8 fishAttack;           // Fish Attack Multiplier
    uint8 lgdBonusAtk;          // Legendary Fish Bonus Attack (added to fishAttack on legendary fish)
    uint8 missRegen;            // Miss Regen multiplier | formula:(floor((missRegen/20) * fishSize) * 10)
    uint8 lgdMissRegen;         // Miss Regen against legendary fish
    uint8 fishTime;             // Rod base catch time limit
    uint8 lgdBonusTime;         // Legendary fish bonus time.
    uint8 smDelayBonus;         // Small fish arrow delay bonus
    uint8 smMoveBonus;          // Small fish movement bonus
    uint8 lgDelayBonus;         // Large fish arrow delay bonus
    uint8 lgMoveBonus;          // Large fish movement bonus
    uint8 multiplier;           // muliplier used in time formulas, possibly other things
    bool breakable;             // Is the rod breakable?
    uint32 brokenRodId;         // Replacement broken rod ID
    bool isMMM;                 // Is Moblin Maze Monger rod? (does crazy stat mods)
};

enum FISHACTION : uint8
{
    FISHACTION_CHECK                            = 2,    // This is always the first 0x110 packet. //
    FISHACTION_FINISH                           = 3,    // This is the next 0x110 after 0x115. //
    FISHACTION_END                              = 4,    // This is sent when the fishing session ends completely
    FISHACTION_WARNING                          = 5     // This is the 0x110 packet if the time is going on too long. //
};

enum FISHMESSAGEOFFSET : uint8
{
    FISHMESSAGEOFFSET_NOROD                     = 0x01, // You can't fish without a rod in your hands.
    FISHMESSAGEOFFSET_NOBAIT                    = 0x02, // You can't fish without bait on the hook.
    FISHMESSAGEOFFSET_CANNOTFISH_MOMENT         = 0x03, // You can't fish at the moment.
    FISHMESSAGEOFFSET_CANNOTFISH_TIME           = 0x5E, // You can't fish at this time

    FISHMESSAGEOFFSET_LINEBREAK                 = 0x06, // Your line breaks.

    FISHMESSAGEOFFSET_RODBREAK                  = 0x07, // Your rod breaks.
    FISHMESSAGEOFFSET_RODBREAK_TOOBIG           = 0x11, // Your rod breaks. Whatever caught the hook was pretty big.
    FISHMESSAGEOFFSET_RODBREAK_TOOHEAVY         = 0x12, // Your rod breaks. Whatever caught the hook was too heavy to catch with this rod.

    FISHMESSAGEOFFSET_LOST                      = 0x09, // You lost your catch.
    FISHMESSAGEOFFSET_LOST_TOOSMALL             = 0x13, // You lost your catch. Whatever caught the hook was too small to catch with this rod.
    FISHMESSAGEOFFSET_LOST_LOWSKILL             = 0x14, // You lost your catch due to your lack of skill.
    FISHMESSAGEOFFSET_LOST_TOOBIG               = 0x3C, // You lost your catch. Whatever caught the hook was too large to catch with this rod.

    FISHMESSAGEOFFSET_GIVEUP_BAITLOSS           = 0x24, // You give up and reel in your line.
    FISHMESSAGEOFFSET_GIVEUP                    = 0x25, // You give up.

    FISHMESSAGEOFFSET_CATCH                     = 0x27, // <Player> caught <Fish>
    FISHMESSAGEOFFSET_CATCH_MULTI               = 0x0E, // <Player> caught X <Fish>
    FISHMESSAGEOFFSET_CATCH_INV_FULL            = 0x0A, // <Player> caught <Fish>, but cannot carry any more items. ≺Player≻ regretfully releases the <Fish>
    FISHMESSAGEOFFSET_MONSTER                   = 0x05, // <Player> caught a monster!

    FISHMESSAGEOFFSET_NOCATCH                   = 0x04, // You didn't catch anything.

    FISHMESSAGEOFFSET_WARNING                   = 0x28, // You don't know how much longer you can keep this one on the line...

    FISHMESSAGEOFFSET_HOOKED_SMALL_FISH         = 0x08, // Something caught the hook!
    FISHMESSAGEOFFSET_HOOKED_LARGE_FISH         = 0x32, // Something caught the hook!!!
    FISHMESSAGEOFFSET_HOOKED_ITEM               = 0x33, // You feel something pulling at your line.
    FISHMESSAGEOFFSET_HOOKED_MONSTER            = 0x34, // Something clamps onto your line ferociously!

    FISHMESSAGEOFFSET_GOOD_FEELING              = 0x29, // You have a good feeling about this one!
    FISHMESSAGEOFFSET_BAD_FEELING               = 0x2A, // You have a bad feeling about this one. 
    FISHMESSAGEOFFSET_TERRIBLE_FEELING          = 0x2B, // You have a terrible feeling about this one...
    FISHMESSAGEOFFSET_NOSKILL_FEELING           = 0x2C, // You don't know if you have enough skill to reel this one in.
    FISHMESSAGEOFFSET_NOSKILL_SURE_FEELING      = 0x2D, // You're fairly sure you don't have enough skill to reel this one in.
    FISHMESSAGEOFFSET_NOSKILL_POSITIVE_FEELING  = 0x2E, // You're positive you don't have enough skill to reel this one in!
    FISHMESSAGEOFFSET_KEEN_ANGLERS_SENSE        = 0x35, // Your keen angler's senses tell you that this is the pull of <name of fish>
    FISHMESSAGEOFFSET_EPIC_CATCH                = 0x36, // This strength... You get the sense that you are on the verge of an epic catch! (apparently happens when large fish length is within 90-100% of it's max length)

    FISHMESSAGEOFFSET_CATCH_CHEST               = 0x40  // <Player> fishes up a large box!
};

enum FISHINGSENSETYPE : uint8
{
    FISHINGSENSETYPE_NONE                       = 0,
    FISHINGSENSETYPE_GOOD                       = 1,
    FISHINGSENSETYPE_BAD                        = 2,
    FISHINGSENSETYPE_TERRIBLE                   = 3,
    FISHINGSENSETYPE_NOSKILL_FEELING            = 4,
    FISHINGSENSETYPE_NOSKILL_SURE_FEELING       = 5,
    FISHINGSENSETYPE_NOSKILL_POSITIVEFEELING    = 6,
    FISHINGSENSETYPE_KEEN_ANGLERS_SENSE         = 7,
    FISHINGSENSETYPE_EPIC_CATCH                 = 8,
};

enum FISHINGHOOKSENSETYPE : uint8
{
    FISHINGHOOKSENSETYPE_SMALL                  = 0,
    FISHINGHOOKSENSETYPE_LARGE                  = 1,
    FISHINGHOOKSENSETYPE_KEENSMALL              = 2,
    FISHINGHOOKSENSETYPE_KEENLARGE              = 3
};

enum FISHINGRODMATERIAL : uint8
{
    FISHINGRODMATERIAL_WOOD                     = 0,
    FISHINGRODMATERIAL_SYNTHETIC                = 1
};

enum FISHINGWATERTYPE : uint8
{
    FISHINGWATERTYPE_ALL                        = 0,
    FISHINGWATERTYPE_FRESH                      = 1,
    FISHINGWATERTYPE_SALT                       = 2
};

enum FISHINGTIMEPREF : uint8
{
    FISHINGTIMEPREF_ALL                         = 0,
    FISHINGTIMEPREF_DAY                         = 1,
    FISHINGTIMEPREF_NIGHT                       = 2
};

enum FISHINGMOONPREF : uint8
{
    FISHINGMOONPREF_ALL                         = 0,
    FISHINGMOONPREF_FULL                        = 1,
    FISHINGMOONPREF_NEW                         = 2
};

enum FISHINGLOCATIONTYPE : uint8
{
    FISHINGLOCATIONTYPE_ALL                     = 0,
    FISHINGLOCATIONTYPE_CITY                    = 1,
    FISHINGLOCATIONTYPE_OUTSIDE                 = 2
};

enum FISHINGCATCHTYPE : uint8
{
    FISHINGCATCHTYPE_NONE                       = 0,
    FISHINGCATCHTYPE_SMALLFISH                  = 1,
    FISHINGCATCHTYPE_BIGFISH                    = 2,
    FISHINGCATCHTYPE_ITEM                       = 3,
    FISHINGCATCHTYPE_MOB                        = 4,
    FISHINGCATCHTYPE_CHEST                      = 5,
    FISHINGCATCHTYPE_SMALL_CUSTOM               = 6,
    FISHINGCATCHTYPE_LARGE_CUSTOM               = 7,
    FISHINGCATCHTYPE_MOB_CUSTOM                 = 8
};

enum FISHINGSUCCESSTYPE : uint8
{
    FISHINGSUCCESSTYPE_NONE                     = 0,
    FISHINGSUCCESSTYPE_CATCHITEM                = 1,
    FISHINGSUCCESSTYPE_CATCHSMALL               = 2,
    FISHINGSUCCESSTYPE_CATCHLARGE               = 3,
    FISHINGSUCCESSTYPE_CATCHLEGEND              = 4,
    FISHINGSUCCESSTYPE_CATCHMOB                 = 5,
    FISHINGSUCCESSTYPE_LINEBREAK                = 6,
    FISHINGSUCCESSTYPE_RODBREAK                 = 7,
    FISHINGSUCCESSTYPE_LOSTCATCH                = 8,
    FISHINGSUCCESSTYPE_CATCHCHEST               = 9,
    FISHINGSUCCESSTYPE_CATCHSMALL_CUSTOM        = 10,
    FISHINGSUCCESSTYPE_CATCHLARGE_CUSTOM        = 11,
    FISHINGSUCCESSTYPE_CATCHMOB_CUSTOM          = 12
};

enum FISHINGFAILTYPE : uint8
{
    FISHINGFAILTYPE_NONE                        = 0, 
    FISHINGFAILTYPE_SYSTEM                      = 1,
    FISHINGFAILTYPE_LINESNAP                    = 2,
    FISHINGFAILTYPE_RODBREAK                    = 3,
    FISHINGFAILTYPE_RODBREAK_TOOBIG             = 4,
    FISHINGFAILTYPE_RODBREAK_TOOHEAVY           = 5,
    FISHINGFAILTYPE_LOST                        = 6,
    FISHINGFAILTYPE_LOST_TOOSMALL               = 7,
    FISHINGFAILTYPE_LOST_LOWSKILL               = 8,
    FISHINGFAILTYPE_LOST_TOOBIG                 = 9
};

enum FISHINGSIZETYPE : uint8
{
    FISHINGSIZETYPE_SMALL                       = 0, // small fish
    FISHINGSIZETYPE_LARGE                       = 1, // large fish
    FISHINGSIZETYPE_LEGEND                      = 2  // legendary fish
};

enum FISHINGLURETYPE : uint8
{
    FISHINGLURETYPE_BAIT                        = 0, // stackable/consumable baits
    FISHINGLURETYPE_LURE                        = 1, // reusable lures
    FISHINGLURETYPE_SPECIAL                     = 2  // Used to fish up NM, one time use only
};

enum FISHINGBOUNDTYPE : uint8
{
    FISHINGBOUNDTYPE_ZONE                       = 0, // entire zone
    FISHINGBOUNDTYPE_RADIUS                     = 1, // bounding radius/cylinder
    FISHINGBOUNDTYPE_POLY                       = 2  // bounding polygon/cube
};

enum FISHFLAG : uint32
{
    FISHFLAG_NORMAL                             = 0x00,
    FISHFLAG_HALF_SIZE                          = 0x01,  // halves the size attribute for rod formulas
    FISHFLAG_BOTTOM_FEEDER                      = 0x02,  // low swimming fish, easier to catch with sinking bait
    FISHFLAG_TROPICAL                           = 0x04,  // more catchable during high tides
    FISHFLAG_RUSTY                              = 0x08,  // rusty items
    FISHFLAG_DOUBLE_SIZE                        = 0x10   // doubles the size attribute
};

enum LUREFLAG : uint32
{
    LUREFLAG_NORMAL                             = 0x00,
    LUREFLAG_SINKING                            = 0x01,
    LUREFLAG_ITEM_BONUS                         = 0x02,
    LUREFLAG_ITEM_MEGA_BONUS                    = 0x04
};

enum RODFLAG : uint32
{
    RODFLAG_NORMAL                              = 0x00,
    RODFLAG_SMALLPENALTY                        = 0x01,
    RODFLAG_LARGEPENALTY                        = 0x02,
    RODFLAG_LEGENDARYBONUS                      = 0x04
};

enum FISHINGLEGENDARY : uint32
{
    FISHINGLEGENDARY_NORMAL                     = 0x00,
    FISHINGLEGENDARY_HALFTIME                   = 0x01,  // cuts base rod fishing time in half
    FISHINGLEGENDARY_NORODTIMEBONUS             = 0x02,  // do not add the normal legendary rod bonus
    FISHINGLEGENDARY_ADDTIMEBONUS               = 0x04   // add bonus fishing time based on rod multiplier
};

enum FISHINGNM : uint32
{
    FISHINGNM_NORMAL                            = 0x00,
    FISHINGNM_RANDOM_REGEN_EASY                 = 0x01,
    FISHINGNM_RANDOM_REGEN_DIFFICULT            = 0x02,
    FISHINGNM_RANDOM_HEAL_EASY                  = 0x04,
    FISHINGNM_RANDOM_HEAL_DIFFICULT             = 0x08,
    FISHINGNM_RANDOM_ATTACK_EASY                = 0x10,
    FISHINGNM_RANDOM_ATTACK_DIFFICULT           = 0x20,
    FISHINGNM_RESET_RESPAWN_ON_FAIL             = 0x40
};

/************************************************************************
*                                                                       *
*  All the methods necessary for the implementation of fishing          *
*                                                                       *
************************************************************************/

class CCharEntity;

namespace fishingutils
{
    void LoadFishingMessages();
    void SendSenseMessage(CCharEntity* PChar, fishresponse_t *response);
    fishingarea_t *GetFishingArea(CCharEntity* PChar);
    void StartFishing(CCharEntity* PChar);
    void FishingAction(CCharEntity* PChar, FISHACTION action, uint16 stamina, uint32 special);
};

#endif