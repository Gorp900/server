-----------------------------------
-- Area: Selbina
--  NPC: Battal
-- Type: Melody Minstrel NPC
-- !pos TODO
-----------------------------------
---@type TNpcEntity
local entity = {}

-- eventId is unique to each NPC
local eventId = 1102

-- Big Dict of the cutscene event ID's
-- Format is :[Chosen Option from NPC's menu] = Relevant Cutscene ID
local cutscenes =
{
    [1]   = 81,      --? The Rescue
    [2]   = 173,    -- Aldo
    [3]   = 31,     --? Under the Sea
    --4 = ? Picture Perfect 1
    --5 = ? Picture Perfect 2
    --33 = ? Tenshodo Showdown 1
    --34 = ? Tenshodo Showdown 2
    [35]  = 1101,   --? I'll Take the Big Box
    --36 = ? Its rainign mannequins
    --37 = ? signed in blood 1
    --38 = ? signedd in blood 2
    --39 = ? chasign ddreams
    --40 = ? treasures of the earth 1
    --41 = ? treasures of the earth 2
    [65]  = 10005,  -- CoP 6-3: More Questions than Answers
    [97]  = 176,    --? Emissary from the Seas
    [98]  = 177,    --? Set Free
    [99]  = 178,    --? The Beginning (pt.1)
    [100] = 179,    --? The Beginning (pt.2)
}

-- TODO: Looks like for each item in the submenu goes up in bitwise 2's (2,4,8,16,32 ....)
  -- Because it's simply a set of binary flags, but we need to go up to 32 possible options, it would be good to set the bits themselves but im not sure how this is done atm
  -- So for now, i'm simply subtracting whole values.
    -- This feels like it'd be a bit gross once it gets a bit too big.  surely there's some other way to check how far through a set of missions/quests we are?
    --  except, probably not, considering that there at least is some cutscenes that are untethered to any quest or mission, and likewise, just quests in general will
    --  fit into a weird line of events, heck even missions in the option window will not be aligned with order of mission?
function calculateRequirements(player)
    -- Each Minstrel needs this set of values to begin with and get altered later.
    local csRequirements =
    {
        [1] = 0xFFFFFFFE,   -- SELBINA_QUESTS
        [2] = 0xFFFFFFFE,   -- OTHER_QUESTS
        [3] = 0xFFFFFFFE,   -- PROMATHIA_MISSIONS
        [4] = 0xFFFFFFFE,   -- ADDITIONAL_SCENARIOS
        [5] = 0xFFFFFFFE,   -- EMPTY
        [6] = 0xFFFFFFFE,   -- EMPTY
    }

    -- SELBINA_QUESTS
    -- Aldo
    if player:hasCompletedUniqueEvent(xi.uniqueEvent.MET_MATHILDES_SON) then
        csRequirements[1] = csRequirements[1] - 4
    end

    -- PROMATHIA_MISSIONS
    -- CoP 6-3: More Questions than Answers 
    if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS) then
        csRequirements[3] = csRequirements[3] - 2
    end

    return csRequirements 
end


entity.onTrigger = function(player, npc)
    local csUnlocks = calculateRequirements(player)
    xi.melodyMinstrel.onTrigger(player, eventId, csUnlocks)
end

entity.onEventUpdate =  function(player, csid, option, npc)
    xi.melodyMinstrel.onEventUpdate(player, csid, eventId, cutscenes[option])
end

return entity
