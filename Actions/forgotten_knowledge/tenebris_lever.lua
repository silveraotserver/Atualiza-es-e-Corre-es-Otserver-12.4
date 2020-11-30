local config = {
	verificarStorage = 0,
	centerRoom = Position(32912, 31599, 14),
	bossPosition = Position(32912, 31599, 14),
	newPosition = Position(32911, 31603, 14)
}

local function clearTenebris()
	local spectators = Game.getSpectators(config.centerRoom, false, false, 15, 15, 15, 15)
	for i = 1, #spectators do
		local spectator = spectators[i]
		if spectator:isPlayer() then
			spectator:teleportTo(Position(32902, 31629, 14))
			spectator:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			spectator:say('Time out! You were teleported out by strange forces.', TALKTYPE_MONSTER_SAY)
		elseif spectator:isMonster() then
			spectator:remove()
		end
	end
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 9825 then
		if player:getPosition() ~= Position(32902, 31623, 14) then
			return true
		end
	end
	if item.itemid == 9825 then
		local verificarStorage = 0
		if player:getExhaustion(Storage.ForgottenKnowledge.LadyTenebrisTimer) > 0 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You recently challenged Lady Tenebris. You can challenge him again in 6 hours.")
			return true
		end
		local specs, spec = Game.getSpectators(config.centerRoom, false, false, 15, 15, 15, 15)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone is fighting with Lady Tenebris.")
				return true
			end
		end
		for d = 1, 6 do
			Game.createMonster('shadow tentacle', Position(math.random(32909, 32914), math.random(31596, 31601), 14), true, true)
		end
		Game.createMonster("lady tenebris", config.bossPosition, true, true)
		for y = 31623, 31627 do
			local playerTile = Tile(Position(32902, y, 14)):getTopCreature()
			if playerTile and playerTile:isPlayer() then
				if playerTile:getExhaustion(Storage.ForgottenKnowledge.LadyTenebrisTimer) >= 1 then
					verificarStorage = config.verificarStorage + 1
				end
			end
		end
		
		for y = 31623, 31627 do
			local playerTile = Tile(Position(32902, y, 14)):getTopCreature()
			if playerTile and playerTile:isPlayer() then
				if verificarStorage >= 1 then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone didn't wait 6 hours")				
					return true
				end
			end
		end
		
		for y = 31623, 31627 do
			local playerTile = Tile(Position(32902, y, 14)):getTopCreature()
			if playerTile and playerTile:isPlayer() then
				if verificarStorage < 1 then
					playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
					playerTile:teleportTo(config.newPosition)
					playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					playerTile:setExhaustion(Storage.ForgottenKnowledge.LadyTenebrisTimer, 6.0 * 60.0 * 60.0)
				end
				
			end
		end		
		addEvent(clearTenebris, 20 * 60 * 1000, Position(32902, 31589, 14), Position(32922, 31589, 14), Position(32924, 31610, 14))
		item:transform(9826)
	elseif item.itemid == 9826 then
		item:transform(9825)
	end
	return true
end