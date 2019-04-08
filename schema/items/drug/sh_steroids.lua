ITEM.name = "Steroids"
ITEM.model = "models/stalker/item/medical/psy_pills.mdl"
ITEM.desc = "Steroid pills"
ITEM.duration = 240
ITEM.price = 20
ITEM.attribBoosts = {
	["str"] = 6,
}

ITEM:hook("_use", function(item)
	item.player:EmitSound("items/battery_pickup.wav")
	item.player:ChatPrint(table.Random(effectText))
	item.player:ScreenFade(1, Color(255, 255, 255, 255), 3, 0)
end)