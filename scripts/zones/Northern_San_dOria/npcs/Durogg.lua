-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Durogg
-- Type: Melody Minstrel NPC
-- !pos 15 0 -18 231
-----------------------------------
---@type TNpcEntity
local entity = {}

-- eventId is unique to each Melody Minstrel NPC
local eventId = 865

-- Table includes all possible cutscenes and requirements that this npc will handle
local csInfo =
{
    { -- ADD-ON SCENARIOS
        -- TODO: Something is not working right with the AMK cutscenes here, the cutscene never wants to load the moghouse interior.
        --       It just always plays the cutscene as if you're standing in the middle of north sandoria, will need more testing.
        --       It might have something to do with the players own nation, I've only tested so far with Bastok and that one works fine.
        { csId = 30023, type = "",          log = xi.mission.log_id.AMK,    requirement = xi.mission.id.amk.DRENCHED_IT_BEGAN_WITH_A_RAINDROP,  csParams = xi.melodyMinstrel.extras.MOGHOUSE },
        { csId = 30024, type = "",          log = xi.mission.log_id.AMK,    requirement = xi.mission.id.amk.DRENCHED_IT_BEGAN_WITH_A_RAINDROP,  csParams = xi.melodyMinstrel.extras.MOGHOUSE },
        -- { csId = 0,     type = "",          log = xi.mission.log_id.TVR,    requirement = xi.mission.id.tvr.MOGLESSE_OBLIGE }, -- Voracious Resurgance 11-1, not implemented yet
    },
    { -- SEEKERS OF ADOULIN
        { csId = 878,   type = "mission",   log = xi.mission.log_id.SOA,    requirement = xi.mission.id.soa.RUMORS_FROM_THE_WEST },
    },
}

entity.onTrigger = function(player)
    xi.melodyMinstrel.onTrigger(player, eventId, csInfo)
end

entity.onEventUpdate =  function(player, csid, option)
    xi.melodyMinstrel.onEventUpdate(player, csid, eventId, option, csInfo)
end

return entity
