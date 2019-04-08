ITEM.name = "Painkillers"
ITEM.model = "models/w_models/weapons/w_eq_painpills.mdl"
ITEM.desc = "A bottle of painkillers"
ITEM.duration = 240
ITEM.price = 20
ITEM.attribBoosts = {
	["end"] = 6,
}

ITEM:hook("_use", function(item)
	item.player:EmitSound("items/battery_pickup.wav")
	item.player:ChatPrint(table.Random(effectText))
	item.player:ScreenFade(1, Color(255, 255, 255, 255), 3, 0)
end)