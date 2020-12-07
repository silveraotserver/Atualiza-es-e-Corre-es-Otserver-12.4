local level = 100
local paladin = 3
local rp = 7
local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getLevel() < level then
		player:say("You aren't level 100 or higher", TALKTYPE_MONSTER_SAY)
		return true 
	end
	if player:getStorageValue(Storage.Recompensalvl100.Paladin) == 1 then
		player:say("You already looted this chest", TALKTYPE_MONSTER_SAY)
		return true
	end	
	if backpack and backpack:getEmptySlots(false) < 6 or player:getFreeCapacity() < 239 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Please make sure that you have at least 6 free inventory slots and that you can carry on additional 239 oz.')
			return true
		end	
	if player:getVocation() == paladin or player:getVocation() == rp then
		player:addItem(2475, 1)  -- warrior helmet
		player:addItem(8891, 1)  -- paladin armor
		player:addItem(2477, 1)  -- knight legs
		player:addItem(2195, 1)	 -- boh	
		player:addItem(2520, 1)  -- demon shield
		player:addItem(7368, 1)  -- assassin star
		player:setStorageValue(Storage.Recompensalvl100.Paladin, 1)
	else
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Please make sure that you are a paladin or a royal paladin.')
	return true
end