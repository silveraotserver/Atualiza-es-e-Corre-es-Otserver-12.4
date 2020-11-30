function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 10029 then
		Game.createItem(6116, 1, Position(33477, 32698, 14))
	end
end
		item:transform(10030)
	elseif item.itemid == 10030 then
		item:transform(10029)
	end
	return true
end
