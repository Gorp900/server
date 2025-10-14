-----------------------------------
-- Area: Bastok Markets
--  NPC: Lamepaue
-- Type: Melody Minstrel NPC
-- !pos -172.136 -5 -69.632 235
-----------------------------------
---@type TNpcEntity
local entity = {}

-- eventId is unique to each Melody Minstrel NPC
local eventId = 326

-- Table includes all possible cutscenes and requirements that this npc will handle
local csInfo =
{
    { -- BASTOK MISSIONS
        -- TODO: For missions such as Bastok 1-3: Fetichism, where you can get different cutscenes depending on which guard you complete it with,
        --  There is a case to be made where we might want some additional requirements to check which particular cutscene a player has seen, rather than have access to them all.
        --  Personally I do not think it's that important to determine, but it would be more accurate to retail.
        --  I don't think we have anything that tracks specifically which cutscenes a player has seen or not, nor does the mission script really care to track it.
        --  So we would need to add some new kind of player var, or mission vars for anything that can be done in this fashion.
        { csId = 1008, type = "mission", log = xi.mission.log_id.BASTOK, requirement = xi.mission.id.bastok.FETICHISM },
        { csId = 1010, type = "mission", log = xi.mission.log_id.BASTOK, requirement = xi.mission.id.bastok.TO_THE_FORSAKEN_MINES },
    },
    { -- BASTOK QUESTS
--        { csId = 243, type = "quest", log = , requirement = },
--        { csId = , type = "quest", log = , requirement = },
--        { csId = 329, type = "quest", log = , requirement = },
--        { csId = 332, type = "quest", log = , requirement = },
--        { csId = 334, type = "quest", log = , requirement = },
--        { csId = 185, type = "quest", log = , requirement = },
--        { csId = 441, type = "quest", log = , requirement = },
--        { csId = 411, type = "quest", log = , requirement = },
--        { csId = 475, type = "quest", log = , requirement = },
--        { csId = 477, type = "quest", log = , requirement = },
--        { csId = 479, type = "quest", log = , requirement = },
--        { csId = 481, type = "quest", log = , requirement = },
--        { csId = 483, type = "quest", log = , requirement = },
--        { csId = 485, type = "quest", log = , requirement = },
    },
    { -- OTHER QUESTS
--        { csId = 402, type = "quest", log = , requirement = },
--        { csId = 403, type = "quest", log = , requirement = },
--        { csId = 404, type = "quest", log = , requirement = },
--        { csId = 405, type = "quest", log = , requirement = },
--        { csId = 406, type = "quest", log = , requirement = },
--        { csId = 434, type = "quest", log = , requirement = },
--        { csId = 437, type = "quest", log = , requirement = },
--        { csId = 439, type = "quest", log = , requirement = },
--        { csId = 490, type = "quest", log = , requirement = },
--        { csId = , type = "quest", log = , requirement = },
--        { csId = , type = "quest", log = , requirement = },
--        { csId = 18, type = "quest", log = , requirement = },
--        { csId = 12, type = "quest", log = , requirement = },
--        { csId = 258, type = "quest", log = , requirement = },
--        { csId = , type = "quest", log = , requirement = },
--        { csId = , type = "quest", log = , requirement = },
--        { csId = , type = "quest", log = , requirement = },
--        { csId = , type = "quest", log = , requirement = },
--        { csId = , type = "quest", log = , requirement = },
--        { csId = , type = "quest", log = , requirement = },
    },
    { -- ADD-ON SCENARIOS
        { csId = 30025, type = "mission", log = xi.mission.log_id.AMK, requirement = xi.mission.id.amk.DRENCHED_IT_BEGAN_WITH_A_RAINDROP, extraInfo = "mogHouse" },
        { csId = 30026, type = "mission", log = xi.mission.log_id.AMK, requirement = xi.mission.id.amk.DRENCHED_IT_BEGAN_WITH_A_RAINDROP, extraInfo = "mogHouse" },
--        { csId = , type = "mission", log = , requirement = },
--        { csId = , type = "mission", log = , requirement = },
--        { csId = , type = "mission", log = , requirement = },
--        { csId = , type = "mission", log = , requirement = },
--        { csId = , type = "mission", log = , requirement = },
--        { csId = , type = "mission", log = , requirement = },
--        { csId = , type = "mission", log = , requirement = },
--        { csId = , type = "mission", log = , requirement = },
--        { csId = , type = "mission", log = , requirement = },
--        { csId = , type = "mission", log = , requirement = },
--        { csId = , type = "mission", log = , requirement = },
    },
    { -- SEEKER OF ADOULIN
--        { csId = , type = "mission", log = , requirement = },
    },
}

entity.onTrigger = function(player)
    xi.melodyMinstrel.onTrigger(player, eventId, csInfo)
end

entity.onEventUpdate =  function(player, csid, option)
    xi.melodyMinstrel.onEventUpdate(player, csid, eventId, option, csInfo)
end

return entity
