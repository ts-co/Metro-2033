ITEM.name = "Whiskey"
ITEM.desc = "A bottle of Whiskey"
ITEM.model = "models/teebeutel/metro/objects/bottle03.mdl"
ITEM.price = 10
ITEM.duration = 300
ITEM.attribBoosts = {
	["end"] = 4,
}

ITEM:hook("_drink", function(item)
	item.player:EmitSound("npc/barnacle/barnacle_gulp1.wav")
	item.player:ScreenFade(1, Color(255, 255, 255, 255), 3, 0)
end)