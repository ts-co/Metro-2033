ITEM.name = "''Anastasiya''"
ITEM.desc = "A bottle of homemade moonshine"
ITEM.model = "models/props_junk/glassjug01.mdl"
ITEM.price = 8
ITEM.duration = 360
ITEM.attribBoosts = {
	["end"] = 6,
}

ITEM:hook("_drink", function(item)
	item.player:EmitSound("npc/barnacle/barnacle_gulp1.wav")
	item.player:ScreenFade(1, Color(255, 255, 255, 255), 3, 0)
end)