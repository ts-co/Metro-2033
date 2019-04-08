ITEM.name = "Krokodil"
ITEM.model = "models/props_c17/TrapPropeller_Lever.mdl"
ITEM.desc = "A highly addictive drug that's injected"
ITEM.duration = 100
ITEM.price = 20
ITEM.attribBoosts = {
	["end"] = 3
}

local effectText = {
	"You feel a sudden intense feeling of euphoria.",
}
ITEM:hook("_use", function(item)
	item.player:EmitSound("items/battery_pickup.wav")
	item.player:ChatPrint(table.Random(effectText))
	item.player:ScreenFade(1, Color(255, 255, 255, 255), 3, 0)
end)