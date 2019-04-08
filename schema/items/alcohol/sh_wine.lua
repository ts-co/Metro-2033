ITEM.name = "Wine"
ITEM.desc = "A bottle of Red Wine"
ITEM.model = "models/fallout 3/wine.mdl"
ITEM.price = 14
ITEM.duration = 300
ITEM.attribBoosts = {
	["end"] = 1,
}

ITEM:hook("_drink", function(item)
	item.player:EmitSound("npc/barnacle/barnacle_gulp1.wav")
	item.player:ScreenFade(1, Color(255, 255, 255, 255), 3, 0)
end)
