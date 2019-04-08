ITEM.name = "Beer"
ITEM.desc = "A bottle of homemade beer"
ITEM.model = "models/fallout 3/beer.mdl"
ITEM.price = 3
ITEM.duration = 90
ITEM.attribBoosts = {
	["end"] = 1,
}

ITEM:hook("_drink", function(item)
	item.player:EmitSound("npc/barnacle/barnacle_gulp1.wav")
	item.player:ScreenFade(1, Color(255, 255, 255, 255), 3, 0)
end)