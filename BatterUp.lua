-- Made by JimmyHelp
-- V1

local batterUp = {}

local swinging
local isSwing
function events.tick()
    swinging = player:getSwingTime() == 1
    isSwing = player:isSwingingArm()
end
    
local function getSwing(arm)
    if arm == "right" then
        return (player:getSwingArm() == (player:isLeftHanded() and "OFF_HAND" or "MAIN_HAND")) and  player:getPose() ~= "SLEEPING"
    elseif arm == "left" then
        return (player:getSwingArm() == (not player:isLeftHanded() and "OFF_HAND" or "MAIN_HAND")) and player:getPose() ~= "SLEEPING"
    else
        return true
    end
end

local function getItem(itemid,handy)
    if not itemid then return true end
    if handy == "right" then
        return player:getHeldItem(player:isLeftHanded()).id:find(itemid) or player:getHeldItem(player:isLeftHanded()):getName():find(itemid)
    elseif handy == "left" then
        return player:getHeldItem(not player:isLeftHanded()).id:find(itemid) or player:getHeldItem(not player:isLeftHanded()):getName():find(itemid)
    end
end

local hitBlock
local function isMining(mine)
    local targetBlock = player:getTargetedBlock(true, player:getGamemode() == "CREATIVE" and 5 or 4.5)
    local blockSuccess, blockResult = pcall(targetBlock.getTextures, targetBlock)
    if blockSuccess then hitBlock = not (next(blockResult) == nil) else hitBlock = true end
    if mine == "mine" then
        return hitBlock
    elseif mine == "attack" then
        return not hitBlock
    else
        return true
    end
end

local rand = math.random
local function getRandom(length,prev)
    local rResult = rand(length)
    if rResult == prev then
        return getRandom(length,prev)
    else
        return rResult
    end
end

local function checkTable(table)
    if type(table) ~= "table" then
        error("§aCustom Script Warning: §6The value provided for the first param is not a table.§c",3)
    end
    if #table < 2 then
        error("§aCustom Script Warning: §6The animation table provided is too small, it must contain at least 2 animations, and it currently has ".. #table..". \n".."If your table appears to have multiple animations in it, make sure their names/paths are correct.§c",3)
    end
    for key, value in pairs(table) do
        if type(value) ~= "Animation" then
            error("§aCustom Script Warning: §6At index "..key.." of the provided table, the value is not an animation.§c",3)
        end
    end
end

---@param anims table
---@param hand string
---@param item string
---@param mine string
---@param length boolean
---@param reset number
function batterUp:addChainedSwings(anims,hand,item,mine,length,reset)
    checkTable(anims)
    local chain = #anims
    local timer = 0
    function events.tick()
        if swinging then
            if getSwing(hand) and getItem(item,hand) and isMining(mine) then
                anims[chain]:stop()
                chain = (chain % #anims) + 1
                anims[chain]:restart()
                timer = 0
            end
        end
        if isSwing and length then
            anims[chain]:speed((anims[chain]:getLength()*20)/player:getSwingDuration())
        end
        if reset ~= nil then
            timer = timer + 1
            if timer == reset then
                chain = #anims
            end
        end
    end
    return self
end


---@param anims table
---@param hand string
---@param item string
---@param mine string
---@param length boolean
function batterUp:addRandomSwings(anims,hand,item,mine,length)
    checkTable(anims)
    local prev = rand(#anims)
    local result = #anims
    function events.tick()
        if swinging then
            if getSwing(hand) and getItem(item,hand) and isMining(mine) then
                result = getRandom(#anims,prev)
                anims[prev]:stop()
                anims[result]:restart()
                prev = result
            end
        end
        if isSwing and length then
            anims[result]:speed((anims[result]:getLength()*20)/player:getSwingDuration())
        end
    end
    return self
end

return batterUp