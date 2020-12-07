local level = 100
local kngiht = 4
local ek = 8
local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getLevel() < level then
		player:say("You aren't level 100 or higher", TALKTYPE_MONSTER_SAY)
		return true 
	end
	if player:getStorageValue(Storage.Recompensalvl100.Knight) == 1 then
		player:say("You already looted this chest", TALKTYPE_MONSTER_SAY)
		return true
	end	
	if backpack and backpack:getEmptySlots(false) < 8 or player:getFreeCapacity() < 473 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Please make sure that you have at least 8 free inventory slots and that you can carry on additional 473 oz.')
			return true
		end	
	if player:getVocation() == knight or player:getVocation() == ek then
		player:addItem(2475, 1)  -- warrior helmet
		player:addItem(2476, 1)  -- knight armor
		player:addItem(2477, 1)  -- knight legs
		player:addItem(2195, 1)	 -- boh	
		player:addItem(2520, 1)  -- demon shield
		player:addItem(7390, 1)  -- justice seeker
		player:addItem(2747, 1)  -- royal axe
		player:addItem(2747, 1)  -- blessed sceptre
		player:setStorageValue(Storage.Recompensalvl100.Knight, 1)
	else
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Please make sure that you are a knight or a elite knight.')
	return true
end