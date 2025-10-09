-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Durogg
-- Type: Past Event Watcher
-- !pos 15 0 -18 231
-----------------------------------
---@type TNpcEntity
local entity = {}

-- eventId is unique to each Melody Minstrel NPC
local eventId = 865

-- Table includes all possible cutscenes and requirements that this npc will handle
local csInfo =
{
    { -- ADD-ON SCENARIOS
        -- For the below Kupo D'etat cutscenes, there is some other requirement, related to mission.sections[1][zoneId] for this mission.
        --  I beleive the check is to see which location the player actually performed the mission in, since it can be done in so many different moghouses.
        --  this means that a slightly different requirement is needed, not just that the mission is complete, but also WHERE it was complete.
        --  This could also apply to the kind of quest that you can turn in to any gate guard (eg: Bastok 1-3: Fetichism)
        { csId = 30023, type = "mission", log = xi.mission.log_id.AMK, requirement = xi.mission.id.amk.DRENCHED_IT_BEGAN_WITH_A_RAINDROP },
        { csId = 30024, type = "mission", log = xi.mission.log_id.AMK, requirement = xi.mission.id.amk.DRENCHED_IT_BEGAN_WITH_A_RAINDROP },
        { csId = 878, type = "mission", log = xi.mission.log_id.SOA, requirement = xi.mission.id.soa.RUMORS_FROM_THE_WEST }, -- is the csid right?
    },
    { -- SEEKERS OF ADOULIN
        { csId = 878, type = "mission", log = xi.mission.log_id.SOA, requirement = xi.mission.id.soa.RUMORS_FROM_THE_WEST }, -- is the csid right?
        -- TODO: Why does this same cutscene appear for both of these catagories on this npc? something seems wrong here, need retail captures
    },
}

-- Interesting TODO Information with the above cutscenes.
-- SOA: The same cutscene choice is apparently listed in both catagories.  On my own retail capture, i only see it appear in the 2nd catagory.  This may be because the character
    -- I was using was from Bastok.  Could it be that there is a further check per catagory?
-- AMK: Caveat: again my char i captured this with was from bastok: see npc: lamepaue in bastok markets... With that said, here's some info
--  These two cutscenes both appear when DRENCHED_IT_BEGAN_WITH_A_RAINDROP is completed, the first is the cs that starts with a drop, 2nd is when you trade mog the items.
--  We seem to also pass a lot of extra vars when starting these events, so there does appear to be some extra requirement to pass forward.
--  as of now, i beleive the values are handling the check of the players alliegance, and perhaps switching the loaded zone.
--  With nothign passed over, it will load the cutscene in the middle of the area, when it should appear inside the moghouse.
--   Values from bastok are : 0x2CB7553D, 0x00, 0x05, 0x01011009, 0x03FFFFFF, 0x336BFFF6, 0xEB, 0x01
--   No real clue what each one relates to just yet, i will need a capture of a character from sandy and windy

entity.onTrigger = function(player)
    xi.melodyMinstrel.onTrigger(player, eventId, csInfo)
end

entity.onEventUpdate =  function(player, csid, option)
    xi.melodyMinstrel.onEventUpdate(player, csid, eventId, option, csInfo)
end

return entity
