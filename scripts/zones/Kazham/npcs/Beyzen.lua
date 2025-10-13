-----------------------------------
-- Area: Kazham
--  NPC: Beyzen
-- Type: Melody Minstrel NPC
-- !pos -53.976 -9.769 -74.771 250
-----------------------------------
---@type TNpcEntity
local entity = {}

-- eventId is unique to each Melody Minstrel NPC
local eventId = 278

-- Table includes all possible cutscenes and requirements that this npc will handle
local csInfo =
{
    { -- ZILART MISSIONS
        { csId = 114,   type = "mission",   log = xi.mission.log_id.ZILART, requirement = xi.mission.id.zilart.KAZHAMS_CHIEFTAINESS         },
    },
    { -- KAZHAM QUESTS
        { csId = 44,    type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.A_QUESTION_OF_TASTE          },
        { csId = 47,    type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.A_QUESTION_OF_TASTE          },
        { csId = 50,    type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.A_QUESTION_OF_TASTE          },
        { csId = 53,    type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.A_QUESTION_OF_TASTE          },
        { csId = 128,   type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.YOU_CALL_THAT_A_KNIFE        },
        { csId = 133,   type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.YOU_CALL_THAT_A_KNIFE        },
        { csId = 137,   type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.MISSIONARY_MAN               },
        { csId = 139,   type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.MISSIONARY_MAN               },
        { csId = 141,   type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.MISSIONARY_MAN               },
        { csId = 144,   type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.GULLIBLES_TRAVELS            },
        { csId = 146,   type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.GULLIBLES_TRAVELS            },
        { csId = 148,   type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.EVEN_MORE_GULLIBLES_TRAVELS  },
        { csId = 152,   type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.EVEN_MORE_GULLIBLES_TRAVELS  },
        { csId = 191,   type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.PERSONAL_HYGIENE             },
        { csId = 193,   type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.PERSONAL_HYGIENE             },
        { csId = 217,   type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.THE_OPO_OPO_AND_I            },
        { csId = 241,   type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.THE_OPO_OPO_AND_I            },
        { csId = 273,   type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.TRIAL_BY_FIRE                },
        { csId = 279,   type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.CLOAK_AND_DAGGER             },
        { csId = 282,   type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.CLOAK_AND_DAGGER             },
        { csId = 284,   type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.CLOAK_AND_DAGGER             },
    },
    { -- OTHER QUESTS
        { csId = 293,   type = "quest",     log = xi.questLog.WINDURST,     requirement = xi.quest.id.windurst.TUNING_OUT                   },
        { csId = 295,   type = "quest",     log = xi.questLog.WINDURST,     requirement = xi.quest.id.windurst.TUNING_OUT                   },
        { csId = 297,   type = "quest",     log = xi.questLog.WINDURST,     requirement = xi.quest.id.windurst.TUNING_OUT                   },
        { csId = 299,   type = "quest",     log = xi.questLog.BASTOK,       requirement = xi.quest.id.bastok.RETURN_TO_THE_DEPTHS           },
        { csId = 301,   type = "quest",     log = xi.questLog.BASTOK,       requirement = xi.quest.id.bastok.RETURN_TO_THE_DEPTHS           },
        { csId = 313,   type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.VW_OP_054_ELSHIMO_LIST       },
        { csId = 315,   type = "quest",     log = xi.questLog.OUTLANDS,     requirement = xi.quest.id.outlands.VW_OP_054_ELSHIMO_LIST       },
    },
}

entity.onTrigger = function(player)
    xi.melodyMinstrel.onTrigger(player, eventId, csInfo)
end

entity.onEventUpdate =  function(player, csid, option)
    xi.melodyMinstrel.onEventUpdate(player, csid, eventId, option, csInfo)
end

return entity

