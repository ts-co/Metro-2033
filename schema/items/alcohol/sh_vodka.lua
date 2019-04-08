ITEM.name = "Vodka"
ITEM.desc = "A bottle of Shroom Vodka"
ITEM.model = "models/teebeutel/metro/objects/bottle02.mdl"
ITEM.price = 4
ITEM.duration = 320
ITEM.attribBoosts = {
	["end"] = 4,
}

ITEM:hook("_drink", function(item)
	item.player:EmitSound("npc/barnacle/barnacle_gulp1.wav")
	item.player:ScreenFade(1, Color(255, 255, 255, 255), 3, 0)
end)