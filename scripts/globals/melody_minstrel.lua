-----------------------------------
-- Melody Minstrel (Cutscene Viewer Bard) NPC Functions
-----------------------------------
xi = xi or {}
xi.melodyMinstrel = xi.melodyMinstrel or {}

local gilCost = 10

-----------------------------------
-- public melody minstrel functions
-----------------------------------
xi.melodyMinstrel.onTrigger = function(player, eventId, csUnlocks)
    player:startEvent(
        eventId,
        csUnlocks[1],
        csUnlocks[2],
        csUnlocks[3],
        csUnlocks[4],
        csUnlocks[5],
        csUnlocks[6],
        gilCost,
        player:getGil()
    )
end

xi.melodyMinstrel.onEventUpdate = function(player, csid, eventId, cutsceneId)
    if csid == eventId then
        if cutsceneId ~= nil then
            player:delGil(gilCost)
            player:startEvent(cutsceneId)
        else
            player:release() -- Could this be cleaner? At the least for now it will prevent players from getting stuck
        end
    end
end
