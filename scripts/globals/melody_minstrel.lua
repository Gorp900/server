-----------------------------------
-- Melody Minstrel (Cutscene Viewer Bard) NPC Functions
-----------------------------------
xi = xi or {}
xi.melodyMinstrel = xi.melodyMinstrel or {}

-- TODO: Possible way to catagorize some additional info.  Can it just be 1,2,3... rather than flags? Is there a possible way that these might get combined?
xi.melodyMinstrel.extras =
{
    MOGHOUSE           = 0x02,
    BORGHERTZ          = 0x04,
    ADVENTURING_FELLOW = 0x08,
}

-- Cost to player to view a cutscene
local gilCost = 10

local function createList(player, csInfo)
    -- Default menu options
    -- Each Minstrel has up to 6 catagories of cutscenes they can show
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
            -- We only care that a quest/mission has been complete, partially complete quests/missions do not appear on the NPC menu options.
            local flag = 2 ^ choice
            if vals.type == "quest" then
                if vals.extraReqs ~= nil then
                    -- Edge case for all possible Bogherts_XYZ_Hands Quests
                    -- We only really care that the player has completed any one of them
                    if vals.extraReqs == extras.BORGHERTZ then
                        for i in 0, 14 do
                            if player:hasCompletedQuest(vals.log, vals.requirement + i) then
                                menuOptions[catagory] = menuOptions[catagory] - flag
                                break
                            end
                        end
                    end
                elseif player:hasCompletedQuest(vals.log, vals.requirement) then
                    menuOptions[catagory] = menuOptions[catagory] - flag
                end
            elseif vals.type == "mission" then
                if player:hasCompletedMission(vals.log, vals.requirement) then
                    menuOptions[catagory] = menuOptions[catagory] - flag
                end
            elseif vals.type == "uniqueEvent" then
                if player:hasCompletedUniqueEvent(vals.requirement) then
                    menuOptions[catagory] = menuOptions[catagory] - flag
                end
            elseif vals.type == "roe" then
                -- AFAIK: the only cs related to this requirement is the RoE Tutorial/Introduction
                if player:getEminenceCompleted(vals.requirement) then
                    menuOptions[catagory] = menuOptions[catagory] - flag
                end
            elseif vals.type == "unity" then
                -- AFAIK: the only cutscene is the one related to picking a leader, which you must of done if you have a leader
                if player:getUnityLeader() then
                    menuOptions[catagory] = menuOptions[catagory] - flag
                end
            else
                -- could we also need hiddenQuest as a type? Are these handled differently to quests?
                -- For now if we don't get a matching type, assume the cutscenes requirements are simply not implemented right now so we do nothing.
            end
        end
    end

    return menuOptions
end

local function getLocalMogHouse(player)
    local currentZone = player:getZoneID()
    local currentRegion = 0 -- Sandy
    if currentZone >= 234 and currentZone <= 237 then
        currentRegion = 1   -- Basty
    elseif currentZone >= 238 and currentZone <= 242 then
        currentRegion = 2   -- Windy
    end
    -- TODO: Might need to expand the currentRegion to also sort out Jeuno, Adoulin, Aht Urghan, Shadowreign

    -- TODO: Thought some vars might be to do with players furniture, upon investigatiop and captures, it is not, the MH is always empty in cutscenes
    -- It will need some more investigation / captures to determine this, but for now for the purpose of just doing the cutscene at all, just leave it blank.
    -- Some values from my own retail capture are: 0x2CB7553D, 0x00, 0x05, 0x01011009, 0x03FFFFFF, 0x336BFFF6, 0xEB, 0x01
    --  a second attempt at some retail vars:      0x2CBE021A, 0x00, 0xFF, 0x00,       0x03FFFFFF, 0x00059A98, 0xEB, 0x01
    --      Some weird little differences, I was a different job at this point, and i had rearranged mh furniture? unsure what else it could be...
    -- Through my investigation all i know for sure are:
    --   Param 7 is the current zone, needed for when a cutscene loads the map geometry since it has to reload the area you were in
    --   Param 8 is the current city/region, used to determine the look of the moghouse in cutscene and to reload the correct music when cutscene ends
    local result = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, currentZone, currentRegion }
    return result
end

local function getAdventuringFellow(player)
    -- TODO: The current assumption is that we need to get the model/name/whatever for the players adventuring fellow and pass these values to the event as well
    --  For without these values we're going to see incorrect models in the cutscenes.
    --  atm I don't think the adventuring fellow as a feature is in LSB, so this work is blocked until that gets added.
    local result = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 }
    return result
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
        -- 'option modulo 32' will give us the exact record within a catagory (ie: 97 % 32  = 1, option 97 is the 1st record of catagory 4)
        local catagory   = math.ceil(option / 32)
        local choice     = math.fmod(option, 32)
        local cutsceneId = csInfo[catagory][choice].csId
        local csParams   = csInfo[catagory][choice].csParams

        if cutsceneId ~= nil then
            if csParams ~= nil then
                if csParams == extras.MOGHOUSE then
                    player:startEvent(cutsceneId, unpack(getLocalMogHouse(player)))
                elseif csParams == extras.ADVENTURING_FELLOW then
                    player:startEvent(cutsceneId, unpack(getAdventuringFellow(player)))
                end
            else
                player:startEvent(cutsceneId)
            end
            player:delGil(gilCost)
        else
            -- Need to release the player in some fashion since by this point, the screen has faded to black and removed player movement.
            -- It feels like this could be cleaner. At least for now it will prevent players from getting stuck if something goes wrong.
            player:release()
        end
    end
end
