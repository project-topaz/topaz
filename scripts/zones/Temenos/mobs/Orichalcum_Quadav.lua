-----------------------------------
-- Area: Temenos
--  Mob: Orichalcum Quadav
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Temenos/IDs")

function onMobEngaged(mob,target)
  if   (IsMobDead(16929017)==true and IsMobDead(16929018)==true and IsMobDead(16929019)==true and
        IsMobDead(16929020)==true and IsMobDead(16929021)==true and IsMobDead(16929022)==true
    ) then
       mob:setMod(tpz.mod.SLASHSDT, 1400);
       mob:setMod(tpz.mod.PIERCESDT, 1400);
       mob:setMod(tpz.mod.IMPACTSDT, 1400);
       mob:setMod(tpz.mod.HTHSDT, 1400);
  else
      mob:setMod(tpz.mod.SLASHSDT, 300);
      mob:setMod(tpz.mod.PIERCESDT, 300);
      mob:setMod(tpz.mod.IMPACTSDT, 300);
      mob:setMod(tpz.mod.HTHSDT, 300);
  end
  GetMobByID(16929005):updateEnmity(target);
  GetMobByID(16929007):updateEnmity(target);
end;

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        if GetMobByID(ID.mob.TEMENOS_C_MOB[3]):isDead() and GetMobByID(ID.mob.TEMENOS_C_MOB[3]+1):isDead() and
            GetMobByID(ID.mob.TEMENOS_C_MOB[3]+2):isDead()
        then
            GetNPCByID(ID.npc.TEMENOS_C_CRATE[3]):setStatus(tpz.status.NORMAL)
        end
    end
end
