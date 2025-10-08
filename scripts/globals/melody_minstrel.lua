-----------------------------------
-- Melody Minstrel (Cutscene Viewer Bard) NPC Functions
-----------------------------------
xi = xi or {}
xi.melodyMinstrel = xi.melodyMinstrel or {}

local gilCost = 10

local function createList(player, csInfo)
    -- Default menu options
    local menuOptions =
    {
        [1] = 0xFFFFFFFE,
        [2] = 0xFFFFFFFE,
        [3] = 0xFFFFFFFE,
        [4] = 0xFFFFFFFE,
        [5] = 0xFFFFFFFE,
        [6] = 0xFFFFFFFE,
    }

    -- Loop Through all of csInfo
    for catagory, option in pairs(csInfo) do
        for choice, vals in pairs(option) do
            -- For each record in csInfo, we perform whatever check is needed against it's log and requirement
            if vals.type == "quest" then
                if player:hasCompletedQuest(vals.log, vals.requirement) then
                    menuOptions[catagory] = menuOptions[catagory] - vals.listVal
                end
            elseif vals.type == "mission" then
                if player:hasCompletedMission(vals.log, vals.requirement) then
                    menuOptions[catagory] = menuOptions[catagory] - vals.listVal
                end
            elseif vals.type == "uniqueEvent" then
                if player:hasCompletedUniqueEvent(vals.requirement) then
                    menuOptions[catagory] = menuOptions[catagory] - vals.listVal
                end
            else
                -- TODO: Not a quest, mission or uniqueEvent as a requirement, need to cancel out or figure out what else could be done...
                -- Entirely Plausable that we simply do nothing for now, and this will not affect the menuOptions in the slightest.
            end
        end
    end

    return menuOptions
end


-----------------------------------
-- public melody minstrel functions
-----------------------------------
xi.melodyMinstrel.onTrigger = function(player, eventId, csInfo)
    local csUnlocks = createList(player, csInfo)
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

xi.melodyMinstrel.onEventUpdate = function(player, csid, eventId, option, csInfo)
    -- Only continue if it's the Melody Minstrel's own eventID
    if csid == eventId then
        -- Using option, we need to find the correct csId from csInfo
        -- Things to note:
        -- Each catagory can only hold up to 32 options, this is why we use 32 in the below maths.
        -- 'ceil(option/32)' will give us the catagory that option belongs to.
        -- 'option % 32' will give us the exact record within a catagory (ie: 97 % 32  = 1, option 97 is the 1st record of catagory 4)
        local catagory   = math.ceil(option / 32)
        local choice     = math.fmod(option, 32)
        local cutsceneId = csInfo[catagory][choice].csId
        if cutsceneId ~= nil then
             player:delGil(gilCost)
             player:startEvent(cutsceneId)
         else
             player:release() -- Could this be cleaner? At the least for now it will prevent players from getting stuck if something goes wrong.
        end
    end
end
