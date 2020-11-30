local config = {
	verificarStorage = 0,
	centerRoom = Position(32269, 31091, 14),
	bossPosition = Position(32269, 31091, 14),
	newPosition = Position(32271, 31097, 14)
}

local monsters = {
	{monster = 'icicle', pos = Position(32266, 31084, 14)},
	{monster = 'icicle', pos = Position(32272, 31084, 14)},
	{monster = 'dragon egg', pos = Position(32269, 31084, 14)},
	{monster = 'melting frozen horror', pos = Position(32267, 31071, 14)}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 9825 then
		if player:getPosition() ~= Position(32302, 31088, 14) then
			item:transform(9826)
			return true
		end
	end
	if item.itemid == 9825 then
		local verificarStorage = 0
		if player:getExhaustion(Storage.ForgottenKnowledge.HorrorTimer) > 0 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You recently challenged Melting Frozen Horror. You can challenge him again in 6 hours.")
			return true
		end
		local specs, spec = Game.getSpectators(config.centerRoom, false, false, 15, 15, 15, 15)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone is fighting with Melting Frozen Horror.")
				return true
			end
		end
		for n = 1, #monsters do
			Game.createMonster(monsters[n].monster, monsters[n].pos, true, true)
		end
		Game.createMonster("solid frozen horror", config.bossPosition, true, true)
		for y = 31088, 31092 do
			local playerTile = Tile(Position(32302, y, 14)):getTopCreature()
			if playerTile and playerTile:isPlayer() then
				if playerTile:getExhaustion(Storage.ForgottenKnowledge.HorrorTimer) >= 1 then
					verificarStorage = config.verificarStorage + 1
				end
			end
		end
		
		for y = 31088, 31092 do
			local playerTile = Tile(Position(32302, y, 14)):getTopCreature()
			if playerTile and playerTile:isPlayer() then
				if verificarStorage >= 1 then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone didn't wait 6 hours")				
					return true
				end
			end
		end
		
		for y = 31088, 31092 do
			local playerTile = Tile(Position(32302, y, 14)):getTopCreature()
			if playerTile and playerTile:isPlayer() then
				if verificarStorage < 1 then
					playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
					playerTile:teleportTo(config.newPosition)
					playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					playerTile:setExhaustion(Storage.ForgottenKnowledge.HorrorTimer, 6 * 60.0 * 60.0)
				end
				
			end
		end			
		addEvent(clearForgotten, 30 * 60 * 1000, Position(32264, 31070, 14), Position(32284, 31104, 14), Position(32319, 31091, 14))
		item:transform(9826)
	elseif item.itemid == 9826 then
		item:transform(9825)
	end
	return true
end
