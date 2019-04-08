ITEM.name = "drink"
ITEM.Desc = "A drink"
ITEM.model = "models/fallout 3/water.mdl"
ITEM.staminaAmount = 15

ITEM:hook("_use", function(item)
	item.player:EmitSound("npc/barnacle/barnacle_gulp1.wav")
end)


ITEM.functions._use = {
	name = "Drink",
	tip = "Take a Drink",
	icon = "icon16/cup.png",
	onRun = function(item)
	
		if (item.staminaAmount) then
			local value = item.player:getLocalVar("stm", 0) + item.staminaAmount

			item.player:setLocalVar("stm", math.max(100, value))
		end
	end
}