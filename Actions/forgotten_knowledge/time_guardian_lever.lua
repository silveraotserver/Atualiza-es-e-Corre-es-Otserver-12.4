local config = {
	verificarStorage = 0,
	centerRoom = Position(32977, 31662, 14),
	newPosition = Position(32977, 31667, 14)
}

local bosses = {
	{bossPosition = Position(32977, 31662, 14), bossName = 'The Time Guardian'},
	{bossPosition = Position(32975, 31664, 13), bossName = 'The Freezing Time Guardian'},
	{bossPosition = Position(32980, 31664, 13), bossName = 'The Blazing Time Guardian'}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 9825 then
		if player:getPosition() ~= Position(33010, 31660, 14) then
			item:transform(9826)
			return true
		end
	end
	if item.itemid == 9825 then
		local verificarStorage = 0
			if player:getExhaustion(Storage.ForgottenKnowledge.TimeGuardianTimer) > 0 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You recently challenged Time Guardian. You can challenge him again in 6 hours.")
				return true
			end
		local specs, spec = Game.getSpectators(config.centerRoom, false, false, 15, 15, 15, 15)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone is fighting with The Time Guardian.")
				return true
			end
		end
		for q = 1,#bosses do
			Game.createMonster(bosses[q].bossName, bosses[q].bossPosition, true, true)
		end
		for y = 31660, 31664 do
			local playerTile = Tile(Position(33010, y, 14)):getTopCreature()
			if playerTile and playerTile:isPlayer() then
				if playerTile:getExhaustion(Storage.ForgottenKnowledge.TimeGuardianTimer) >= 1 then
					verificarStorage = config.verificarStorage + 1
				end
			end
		end
		
		for y = 31660, 31664 do
			local playerTile = Tile(Position(33010, y, 14)):getTopCreature()
			if playerTile and playerTile:isPlayer() then
				if verificarStorage >= 1 then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone didn't wait 6 hours")				
					return true
				end
			end
		end
		
		for y = 31660, 31664 do
			local playerTile = Tile(Position(33010, y, 14)):getTopCreature()
			if playerTile and playerTile:isPlayer() then
				if verificarStorage < 1 then
					playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
					playerTile:teleportTo(config.newPosition)
					playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					playerTile:setExhaustion(Storage.ForgottenKnowledge.TimeGuardianTimer, 6.0 * 60.0 * 60.0)
				end
			end
		end		
		
		addEvent(clearForgotten, 30 * 60 * 1000, Position(32967, 31654, 13), Position(32989, 31677, 14), Position(32870, 32724, 14))
		item:transform(9826)
		elseif item.itemid == 9826 then
		item:transform(9825)
	end
	return true
end
