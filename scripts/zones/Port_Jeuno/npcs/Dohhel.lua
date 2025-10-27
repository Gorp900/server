-----------------------------------
-- Area: Port Jeuno
--  NPC: Dohhel
-- Type: Melody Minstrel NPC
-- !pos -156.031 -2 6.051 246
-----------------------------------
---@type TNpcEntity
local entity = {}

-- eventId is unique to each Melody Minstrel NPC
local eventId = 10028

-- Table includes all possible cutscenes and requirements that this npc will handle
local csInfo =
{
    { -- MISSIONS
        -- TODO: Figure out what mission CS's Dohhel will show, the wiki has no info on this.
    },
    { -- JEUNO QUESTS
        { csId = 20,    type = "quest", log = xi.questLog.JEUNO,        requirement = xi.quest.id.jeuno.BORGHERTZS_WARRING_HANDS, extraReqs = xi.melodyMinstrel.extras.BORGHERTZ },
        { csId = 48,    type = "quest", log = xi.questLog.JEUNO,        requirement = xi.quest.id.jeuno.BORGHERTZS_WARRING_HANDS, extraReqs = xi.melodyMinstrel.extras.BORGHERTZ },
        { csId = 0,     type = "",      log = xi.questLog.JEUNO,        requirement = xi.quest.id.jeuno.PAST_REFLECTIONS,         csParams = xi.melodyMinstrel.extras.ADVENTURING_FELLOW },
        -- ^ TODO: Another Adventuring Fellow questline, likely needs csParams for correct model
    },
    { -- ADD-ON SCENARIOS
        -- There's something a bit screwey with these Abyssea cutscenes, Joachim doesn't appear in them properly, instead choosing to focus on a different NPC?
        --  It could just be something mismatched with my client version tbh, definitly need to confirm these cutscenes with proper captures, there doesnt appear to be many to reference
        { csId = 324,   type = "",      log = xi.questLog.ABYSSEA,      requirement = xi.quest.id.abyssea.A_JOURNEY_BEGINS },
        { csId = 325,   type = "",      log = xi.questLog.ABYSSEA,      requirement = xi.quest.id.abyssea.THE_TRUTH_BECKONS }, -- Appears with extra params: 66, 0, 4, -2, 1, 1, 1, 3
        { csId = 327,   type = "",      log = xi.questLog.ABYSSEA,      requirement = xi.quest.id.abyssea.DAWN_OF_DEATH }, -- extra params: 12, 0, 3, 0, 1, 1, 1, 3
        { csId = 0,   type = "",      log = xi.questLog.ABYSSEA,      requirement = xi.quest.id.abyssea.FIRST_CONTACT }, -- 333 ?
        { csId = 0,   type = "",      log = xi.questLog.ABYSSEA,      requirement = xi.quest.id.abyssea.HEART_OF_MADNESS }, -- 334 ?
        { csId = 0,   type = "",      log = xi.questLog.ABYSSEA,      requirement = xi.quest.id.abyssea.TENUOUS_EXISTENCE }, -- 335 ? 
        { csId = 0,   type = "",      log = xi.questLog.ABYSSEA,      requirement = xi.quest.id.abyssea.CHAMPIONS_OF_ABYSSEA }, -- 336 ?
        { csId = 0,   type = "",      log = xi.questLog.ABYSSEA,      requirement = xi.quest.id.abyssea.A_SEA_DOGS_SUMMONS },
        { csId = 0,   type = "",      log = xi.questLog.ABYSSEA,      requirement = xi.quest.id.abyssea.DEATH_AND_REBIRTH }, -- 342?
        { csId = 0,   type = "",      log = xi.questLog.ABYSSEA,      requirement = xi.quest.id.abyssea.EMISSARIES_OF_GOD }, -- 343?
        { csId = 0,   type = "",      log = xi.questLog.ABYSSEA,      requirement = xi.quest.id.abyssea.MEANWHILE_BACK_ON_ABYSSEA },
        { csId = 0,   type = "",      log = xi.questLog.ABYSSEA,      requirement = xi.quest.id.abyssea.THE_FORBIDDEN_FRONTIER },
        { csId = 0,   type = "",      log = xi.questLog.ABYSSEA,      requirement = xi.quest.id.abyssea.THE_FORBIDDEN_FRONTIER },
        { csId = 0,   type = "",      log = xi.questLog.ABYSSEA,      requirement = xi.quest.id.abyssea.SCARS_OF_ABYSSEA },
        { csId = 0,   type = "",      log = xi.questLog.ABYSSEA,      requirement = xi.quest.id.abyssea.SCARS_OF_ABYSSEA },
        { csId = 0,   type = "",      log = xi.questLog.ABYSSEA,      requirement = xi.quest.id.abyssea.HEROES_OF_ABYSSEA },
        { csId = 0,   type = "",      log = xi.questLog.ABYSSEA,      requirement = xi.quest.id.abyssea.HEROES_OF_ABYSSEA },
        { csId = 400,   type = "",      log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.NUMBERING_DAYS }, -- extra params: 0, 0, 1, 1, bigflag, bigflag, 4095, 4
        { csId = 0,   type = "",      log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.NUMBERING_DAYS },
        { csId = 0,   type = "",      log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.NUMBERING_DAYS },
        { csId = 0,   type = "",      log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.NUMBERING_DAYS },
        { csId = 0,   type = "",      log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.NUMBERING_DAYS },
        { csId = 0,   type = "",      log = xi.mission.log_id.ROV,    requirement = xi.mission.id.rov.NUMBERING_DAYS },
        -- { csId = 0,   type = "",      log = xi.mission.log_id.TVR,    requirement = xi.mission.id.tvr.DELKFUTT_THE_GREAT }, -- Not Implemented
    },
}

entity.onTrigger = function(player)
    xi.melodyMinstrel.onTrigger(player, eventId, csInfo)
end

entity.onEventUpdate =  function(player, csid, option)
    xi.melodyMinstrel.onEventUpdate(player, csid, eventId, option, csInfo)
end

return entity
