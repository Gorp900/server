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
    { -- SELBINA QUESTS
        { csId = 81,    type = "quest",         log = xi.questLog.OTHER_AREAS,  requirement = xi.quest.id.otherAreas.THE_RESCUE             },
        { csId = 173,   type = "uniqueEvent",   log = nil,                      requirement = xi.uniqueEvent.MET_MATHILDES_SON              }, -- Cutscene: Aldo
        { csId = 31,    type = "quest",         log = xi.questLog.OTHER_AREAS,  requirement = xi.quest.id.otherAreas.UNDER_THE_SEA          },
        { csId = 1110,  type = "quest",         log = xi.questLog.OTHER_AREAS,  requirement = xi.quest.id.otherAreas.PICTURE_PERFECT        },
        { csId = 1114,  type = "quest",         log = xi.questLog.OTHER_AREAS,  requirement = xi.quest.id.otherAreas.PICTURE_PERFECT        },
    },
    { -- OTHER QUESTS
        { csId = 10002, type = "quest",         log = xi.questLog.WINDURST,     requirement = xi.quest.id.windurst.THE_TENSHODO_SHOWDOWN    },
        { csId = 10004, type = "quest",         log = xi.questLog.WINDURST,     requirement = xi.quest.id.windurst.THE_TENSHODO_SHOWDOWN    },
        { csId = 1101,  type = "quest",         log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX    },
        { csId = 1103,  type = "quest",         log = xi.questLog.OTHER_AREAS,  requirement = xi.quest.id.otherAreas.ITS_RAINING_MANNEQUINS },
        { csId = 1104,  type = "quest",         log = xi.questLog.SANDORIA,     requirement = xi.quest.id.sandoria.SIGNED_IN_BLOOD          },
        { csId = 1106,  type = "quest",         log = xi.questLog.SANDORIA,     requirement = xi.quest.id.sandoria.SIGNED_IN_BLOOD          },
        { csId = 1108,  type = "quest",         log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.CHASING_DREAMS           },
        { csId = 10022, type = "quest",         log = xi.questLog.ADOULIN,      requirement = xi.quest.id.adoulin.TREASURES_OF_THE_EARTH    },
        { csId = 10024, type = "quest",         log = xi.questLog.ADOULIN,      requirement = xi.quest.id.adoulin.TREASURES_OF_THE_EARTH    },
    },
    { -- PROMATHIA MISSIONS
        { csId = 10005, type = "mission",       log = xi.mission.log_id.COP,    requirement = xi.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS },
    },
    { -- ADDITIONAL SCENARIOS
        { csId = 176,   type = "mission",       log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.EMISSARY_FROM_THE_SEAS      },
        { csId = 177,   type = "mission",       log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.SET_FREE                    },
        { csId = 178,   type = "mission",       log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.THE_BEGINNING               },
        { csId = 179,   type = "mission",       log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.THE_BEGINNING               },
    },
}

entity.onTrigger = function(player)
    xi.melodyMinstrel.onTrigger(player, eventId, csInfo)
end

entity.onEventUpdate =  function(player, csid, option)
    xi.melodyMinstrel.onEventUpdate(player, csid, eventId, option, csInfo)
end

return entity
