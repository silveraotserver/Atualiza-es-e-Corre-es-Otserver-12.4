local level = 100
local sorcerer = 1
local ms = 5
local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getLevel() < level then
		player:say("You aren't level 100 or higher", TALKTYPE_MONSTER_SAY)
		return true 
	end
	if player:getStorageValue(Storage.Recompensalvl100.Sorcerer) == 1 then
		player:say("You already looted this chest", TALKTYPE_MONSTER_SAY)
		return true
	end	
	if backpack and backpack:getEmptySlots(false) < 6 or player:getFreeCapacity() < 119 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Please make sure that you have at least 6 free inventory slots and that you can carry on additional 119 oz.')
			return true
		end	
	if player:getVocation() == sorcerer or player:getVocation() == ms then
		player:addItem(2323, 1)  -- hat of the mad
		player:addItem(8871, 1)  -- focus cape
		player:addItem(7730, 1)  -- blue legs
		player:addItem(2195, 1)	 -- boh	
		player:addItem(2534, 1)  -- vampire shield
		player:addItem(2187, 1)  -- wand of inferno
		player:setStorageValue(Storage.Recompensalvl100.Sorcerer, 1)
	else
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Please make sure that you are a sorcerer or a master sorcerer.')
	return true
end