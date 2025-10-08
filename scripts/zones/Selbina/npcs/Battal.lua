-----------------------------------
-- Area: Selbina
--  NPC: Battal
-- Type: Melody Minstrel NPC
-- !pos -17.4290 -10.6055 25.9660 238
-----------------------------------
---@type TNpcEntity
local entity = {}

-- eventId is unique to each Melody Minstrel NPC
local eventId = 1102

-- Table includes all possible cutscenes and requirements that this npc will handle
local csInfo =
{
    { -- SELBINA_QUESTS (1-32)
        { listVal = 0x02, csId = 81,  type = "quest",       log = xi.questLog.OTHER_AREAS, requirement = xi.quest.id.otherAreas.THE_RESCUE    },
        { listVal = 0x04, csId = 173, type = "uniqueEvent", log = 0,                       requirement = xi.uniqueEvent.MET_MATHILDES_SON     },
        { listVal = 0x08, csId = 31,  type = "quest",       log = xi.questLog.OTHER_AREAS, requirement = xi.quest.id.otherAreas.UNDER_THE_SEA },
        -- { listVal = 0x10, listOption = 4, csId = ???,  requirement = xi.quest.id.otherAreas.PICTURE_PERFECT },
        -- { listVal = 0x20, listOption = 5, csId = ???,  requirement = xi.quest.id.otherAreas.PICTURE_PERFECT },
    },
    { -- OTHER_QUESTS (33-64)
        { listVal = 0x02, csId = 10002, type = "quest", log = xi.questLog.WINDURST,    requirement = xi.quest.id.windurst.THE_TENSHODO_SHOWDOWN },
        { listVal = 0x04, csId = 10004, type = "quest", log = xi.questLog.WINDURST,    requirement = xi.quest.id.windurst.THE_TENSHODO_SHOWDOWN },
        { listVal = 0x08, csId = 1101,  type = "quest", log = xi.questLog.OUTLANDS,    requirement = xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX },
        { listVal = 0x10, csId = 1103,  type = "quest", log = xi.questLog.OTHER_AREAS, requirement = xi.quest.id.otherAreas.ITS_RAINING_MANNEQUINS },
        { listVal = 0x20, csId = 1104,  type = "quest", log = xi.questLog.SANDORIA,    requirement = xi.quest.id.sandoria.SIGNED_IN_BLOOD },
        { listVal = 0x40, csId = 1106,  type = "quest", log = xi.questLog.SANDORIA,    requirement = xi.quest.id.sandoria.SIGNED_IN_BLOOD },
        { listVal = 0x80, csId = 1108,  type = "quest", log = xi.questLog.OUTLANDS,    requirement = xi.quest.id.outlands.CHASING_DREAMS },
        -- { listVal = 0x100, csId = ???,  requirement = xi.quest.id.adoulin.TREASURES_OF_THE_EARTH },
        -- { listVal = 0x200, csId = ???,  requirement = xi.quest.id.adoulin.TREASURES_OF_THE_EARTH },
    },
    { -- PROMATHIA_MISSIONS (65-96)
        { listVal = 0x02, csId = 10005, type = "mission", log = xi.mission.log_id.COP, requirement = xi.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS },
    },
    { -- ADDITIONAL_SCENARIOS (97 - 128)
        { listVal = 0x02, csId = 176, type = "mission", log = xi.mission.log_id.ROV, requirement = xi.mission.id.rov.EMISSARY_FROM_THE_SEAS },
        { listVal = 0x04, csId = 177, type = "mission", log = xi.mission.log_id.ROV, requirement = xi.mission.id.rov.SET_FREE },
        { listVal = 0x08, csId = 178, type = "mission", log = xi.mission.log_id.ROV, requirement = xi.mission.id.rov.THE_BEGINNING },
        { listVal = 0x10, csId = 179, type = "mission", log = xi.mission.log_id.ROV, requirement = xi.mission.id.rov.THE_BEGINNING },
    },
}

entity.onTrigger = function(player)
    xi.melodyMinstrel.onTrigger(player, eventId, csInfo)
end

entity.onEventUpdate =  function(player, csid, option, npc)
    xi.melodyMinstrel.onEventUpdate(player, csid, eventId, option, csInfo)
end

return entity

