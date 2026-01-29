-----------------------------------
-- Area: Boneyard Gully
--  Mob: Race Runner
--  ENM: Like the Wind
-----------------------------------
---@type TMobEntity
local entity = {}

local pathNodes =
{
    [1] =
    {
        { x = -539, y =  0, z = -481 },
        { x = -559, y =  0, z = -473 },
        { x = -573, y =  0, z = -479 },
        { x = -587, y = -1, z = -474 },
        { x = -589, y = -5, z = -460 },
        { x = -575, y = -4, z = -465 },
        { x = -577, y = -1, z = -453 },
        { x = -561, y =  2, z = -447 },
        { x = -580, y =  1, z = -436 },
        { x = -573, y =  0, z = -419 },
        { x = -552, y =  1, z = -421 },
        { x = -555, y =  2, z = -439 },
        { x = -545, y =  0, z = -443 },
        { x = -530, y = -1, z = -463 },
        { x = -533, y = -1, z = -487 },
    },
    [2] =
    {
        { x =  22, y =  0, z =  78 },
        { x =   2, y =  0, z =  86 },
        { x = -12, y =  0, z =  80 },
        { x = -26, y = -1, z =  85 },
        { x = -28, y = -5, z =  99 },
        { x = -14, y = -4, z =  94 },
        { x = -16, y = -1, z = 106 },
        { x =   0, y =  2, z = 112 },
        { x = -19, y =  1, z = 123 },
        { x = -12, y =  0, z = 140 },
        { x =   9, y =  1, z = 138 },
        { x =   6, y =  2, z = 120 },
        { x =  16, y =  0, z = 116 },
        { x =  31, y = -1, z =  96 },
        { x =  28, y = -1, z =  72 },
    },
    [3] =
    {
        { x = 501, y =  0, z = 560 },
        { x = 481, y =  0, z = 568 },
        { x = 467, y =  0, z = 562 },
        { x = 453, y = -1, z = 567 },
        { x = 451, y = -5, z = 581 },
        { x = 465, y = -4, z = 576 },
        { x = 463, y = -1, z = 588 },
        { x = 479, y =  2, z = 594 },
        { x = 460, y =  1, z = 605 },
        { x = 467, y =  0, z = 622 },
        { x = 488, y =  1, z = 620 },
        { x = 485, y =  2, z = 602 },
        { x = 495, y =  0, z = 598 },
        { x = 510, y = -1, z = 578 },
        { x = 507, y = -1, z = 554 },
    },
}

local runAway = function(mob, target)
    local area = mob:getBattlefield():getArea()

    -- Find closest node that is at least 16 yalms from target, this is so that RR doesn't go too far away to just come running back
    -- This is the exact same as in Selhteus's logic in CoP 8-4
    local closestNode = nil
    local minDist     = 0

    for _, node in ipairs(pathNodes[area]) do
        local distFromTarget = utils.distance(target:getPos(), node)
        local distFromMob  = utils.distance(mob:getPos(), node)

        if distFromTarget >= 16 then
            if distFromMob < minDist or minDist == 0 then
                minDist = distFromMob
                closestNode = node
            end
        end
    end
    mob:pathTo(closestNode.x, closestNode.y, closestNode.z)

    -- Behavior appears to stop doing abilities until we reach our destination so that we prioritize running away
    mob:setLocalVar('runningAway', 1)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setMobAbilityEnabled(false)
end

entity.onMobInitialize = function(mob)
    -- Appears to always be ready to perform skills (able to do abilities within 6-10 seconds of each other), so must have a high regain amount
    mob:addMod(xi.mod.REGAIN, 750)
    mob:addMod(xi.mod.MOVE_SPEED_STACKABLE, 35)
end

entity.onMobSpawn = function(mob)
    local area = mob:getBattlefield():getArea()
    mob:pathThrough(pathNodes[area], xi.path.flag.PATROL)
    mob:setLocalVar('runningAway', 0)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillID = skill:getID()

    if
        skillID == xi.mobSkill.NUMBING_NOISE and
        mob:checkDistance(target) <= 5
    then
        runAway(mob, target)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    -- If our target is basically adjacent to us, we have a much higher chance to use numbing noise over any of our other skills
    -- Likewise, when far away, we have a much higher chance of using toxic spit
    -- I've added up a total of 120 tp skill uses both near and far, and it seems the general chance of these skills is about 66%
    if math.random(1,100) <= 66 then
        if mob:checkDistance(target) <= 5 then
            return xi.mobSkill.NUMBING_NOISE
        else
            return xi.mobSkill.TOXIC_SPIT
        end
    end

    local skillList =
    {
        xi.mobSkill.GEIST_WALL,
        xi.mobSkill.CYCLOTAIL,
        xi.mobSkill.NIMBLE_SNAP,
    }

    return skillList[math.random(1, #skillList)]
end

entity.onMobFight = function(mob, target)
    -- Always avoids targetting pets, focusing on the pet owner
    if target:isPet() then
        target:transferEnmity(target:getMaster(), 100, 100)
    end

    -- When we reach the destination of our path, we re-enable our attacks
    local runningAway = mob:getLocalVar('runningAway')
    if
        runningAway == 1 and
        not mob:isFollowingPath()
    then
        mob:setLocalVar("runningAway", 0)
        mob:setAutoAttackEnabled(true)
        mob:setMagicCastingEnabled(true)
        mob:setMobAbilityEnabled(true)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
