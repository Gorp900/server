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
        { csId = 1008,  type = "mission",   log = xi.mission.log_id.BASTOK, requirement = xi.mission.id.bastok.FETICHISM                    },
        { csId = 1010,  type = "mission",   log = xi.mission.log_id.BASTOK, requirement = xi.mission.id.bastok.TO_THE_FORSAKEN_MINES        },
    },
    { -- BASTOK QUESTS
        { csId = 243,   type = "quest",     log = xi.questLog.BASTOK,       requirement = xi.quest.id.bastok.THE_RETURN_OF_THE_ADVENTURER   },
        { csId = 322,   type = "quest",     log = xi.questLog.BASTOK,       requirement = xi.quest.id.bastok.THE_FIRST_MEETING              },
        { csId = 329,   type = "quest",     log = xi.questLog.BASTOK,       requirement = xi.quest.id.bastok.WISH_UPON_A_STAR               },
        { csId = 332,   type = "quest",     log = xi.questLog.BASTOK,       requirement = xi.quest.id.bastok.WISH_UPON_A_STAR               },
        { csId = 334,   type = "quest",     log = xi.questLog.BASTOK,       requirement = xi.quest.id.bastok.WISH_UPON_A_STAR               },
        { csId = 372,   type = "",          log = xi.questLog.BASTOK,       requirement = xi.quest.id.bastok.ALL_BY_MYSELF                  },
        -- ^ TODO: csid 372 is wrong, Can't seem to pin down the exact id used for the cutscene
        { csId = 441,   type = "",          log = xi.questLog.BASTOK,       requirement = xi.quest.id.bastok.ACHIEVING_TRUE_POWER           },
        -- ^ TODO: 441 Seems like the logical choice for this CS, but doesn't seem to load right
        { csId = 473,   type = "quest",     log = xi.questLog.BASTOK,       requirement = xi.quest.id.bastok.TOO_MANY_CHEFS                 },
        { csId = 475,   type = "quest",     log = xi.questLog.BASTOK,       requirement = xi.quest.id.bastok.A_PROPER_BURIAL                },
        { csId = 477,   type = "quest",     log = xi.questLog.BASTOK,       requirement = xi.quest.id.bastok.A_PROPER_BURIAL                },
        { csId = 479,   type = "quest",     log = xi.questLog.BASTOK,       requirement = xi.quest.id.bastok.A_PROPER_BURIAL                },
        { csId = 481,   type = "quest",     log = xi.questLog.BASTOK,       requirement = xi.quest.id.bastok.A_PROPER_BURIAL                },
        { csId = 483,   type = "quest",     log = xi.questLog.BASTOK,       requirement = xi.quest.id.bastok.A_PROPER_BURIAL                },
        { csId = 485,   type = "quest",     log = xi.questLog.BASTOK,       requirement = xi.quest.id.bastok.A_PROPER_BURIAL                },
    },
    { -- OTHER QUESTS
        { csId = 342,   type = "quest",     log = xi.questLog.JEUNO,        requirement = xi.quest.id.jeuno.BEAT_AROUND_THE_BUSHIN          },
        { csId = 402,   type = "quest",     log = xi.questLog.OTHER_AREAS,  requirement = xi.quest.id.otherAreas.CONFESSIONS_OF_A_BELLMAKER },
        { csId = 403,   type = "",          log = xi.questLog.OTHER_AREAS,  requirement = xi.quest.id.otherAreas.PICTURE_PERFECT,   csParams = xi.melodyMinstrel.extras.ADVENTURING_FELLOW },
        { csId = 404,   type = "",          log = xi.questLog.OTHER_AREAS,  requirement = xi.quest.id.otherAreas.PICTURE_PERFECT,   csParams = xi.melodyMinstrel.extras.ADVENTURING_FELLOW },
        { csId = 405,   type = "",          log = xi.questLog.OTHER_AREAS,  requirement = xi.quest.id.otherAreas.PICTURE_PERFECT,   csParams = xi.melodyMinstrel.extras.ADVENTURING_FELLOW },
        { csId = 406,   type = "",          log = xi.questLog.OTHER_AREAS,  requirement = xi.quest.id.otherAreas.PICTURE_PERFECT,   csParams = xi.melodyMinstrel.extras.ADVENTURING_FELLOW },
        { csId = 434,   type = "quest",     log = xi.questLog.AHT_URHGAN,   requirement = xi.quest.id.ahtUrhgan.NO_STRINGS_ATTACHED         },
        { csId = 437,   type = "quest",     log = xi.questLog.AHT_URHGAN,   requirement = xi.quest.id.ahtUrhgan.PUPPETMASTER_BLUES          },
        { csId = 439,   type = "quest",     log = xi.questLog.AHT_URHGAN,   requirement = xi.quest.id.ahtUrhgan.PUPPETMASTER_BLUES          },
        { csId = 490,   type = "quest",     log = xi.questLog.JEUNO,        requirement = xi.quest.id.jeuno.COMEBACK_QUEEN                  },
        { csId = 492,   type = "",          log = TODO,                     requirement = TODO_DANCER_ATTIRE                                },
        -- ^ Dancer AF pieces, part of a hiddenQuest, TODO: Implement Requirement checking for hiddenQuest? or see what requirement is best.
        { csId = 497,   type = "",          log = TODO,                     requirement = TODO_DANCER_ATTIRE                                },
        -- ^ as above. Also might need csParams var for writing the right piece of equipment in the CS text. see: quests/hiddenQuests/crated_dancer_artifact.lua
        { csId = 0,     type = "",          log = xi.questLog.CRYSTAL_WAR,  requirement = DRAFTED_BY_THE_DUCHY                              },
        { csId = 0,     type = "",          log = xi.questLog.CRYSTAL_WAR,  requirement = BATTLE_ON_A_NEW_FRONT                             },
        { csId = 0,     type = "",          log = xi.questLog.JEUNO,        requirement = VW_OP_126_QUFIM_INCURSION                         },
        -- ^ TODO: Above 3: Unimplemented? Requirement doesn't currently exist but should be this.
        { csId = 24,    type = "roe",       log = nil,                      requirement = 1                                                 },
        -- ^ Requirement is roe_record First_Step_Forward, but does not have appropriate name, only value.
        { csId = 0,     type = "",          log = TODO,                     requirement = TODO_TRUST_MUMOR                                  },
        -- ^ TODO: This CS is tied to the sunbreeze event 2014, how do we even track this if not check if the player has the reward?
        { csId = 595,   type = "",          log = nil,                      requirement = TODO_UNITY_CONCORD                                },
        -- ^ TODO: Similar to above roe type, how best to tackle this requirement? This might also need csParams var, as the model for the voodoo doll is wrong
        { csId = 0,     type = "",          log = nil,                      requirement = TODO_UNITY_CONCORD                                },
        -- ^ TODO: Apparently there is a 2nd Unity Cutscene here, no idea what it is
        { csId = 0,     type = "",          log = TODO,                     requirement = TODO_TRUST_MUMOR_II                               },
        -- ^ TODO: This CS is tied to the sunbreeze event 2015, how do we even track this if not check if the player has the reward?
    },
    { -- ADD-ON SCENARIOS
        { csId = 30025, type = "mission",   log = xi.mission.log_id.AMK,    requirement = xi.mission.id.amk.DRENCHED_IT_BEGAN_WITH_A_RAINDROP, csParams = xi.melodyMinstrel.extras.MOGHOUSE },
        { csId = 30026, type = "mission",   log = xi.mission.log_id.AMK,    requirement = xi.mission.id.amk.DRENCHED_IT_BEGAN_WITH_A_RAINDROP, csParams = xi.melodyMinstrel.extras.MOGHOUSE },
        { csId = 30035, type = "mission",   log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.RHAPSODIES_OF_VANADIEL },   
        { csId = 30036, type = "mission",   log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.WHAT_LIES_BEYOND },
        { csId = 30039, type = "mission",   log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.THE_BEGINNING },
        { csId = 30040, type = "mission",   log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.EVER_FORWARD },
        { csId = 0,     type = "",          log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.DARKNESS_BECKONS }, -- Not implemented
        { csId = 0,     type = "",          log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.DARKNESS_BECKONS }, -- Not implemented
        { csId = 0,     type = "",          log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.DARKNESS_BECKONS }, -- Not implemented
        { csId = 0,     type = "",          log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.DARKNESS_BECKONS }, -- Not implemented
        { csId = 0,     type = "",          log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.DARKNESS_BECKONS }, -- Not implemented
        { csId = 0,     type = "",          log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.FORWARD_THINKING }, -- Not implemented
        { csId = 0,     type = "",          log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.A_DEEP_SLEEP }, -- Not implemented
    },
    { -- SEEKER OF ADOULIN
        { csId = 22,    type = "mission",   log = xi.mission.log_id.SOA,    requirement = xi.mission.id.soa.RUMORS_FROM_THE_WEST },
    },
}

entity.onTrigger = function(player)
    xi.melodyMinstrel.onTrigger(player, eventId, csInfo)
end

entity.onEventUpdate =  function(player, csid, option)
    xi.melodyMinstrel.onEventUpdate(player, csid, eventId, option, csInfo)
end

return entity
