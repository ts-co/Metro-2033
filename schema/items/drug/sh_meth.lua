ITEM.name = "Crystal Meth"
ITEM.model = "models/katharsmodels/contraband/metasync/blue_sky.mdl"
ITEM.desc = "A highly addictive drug that's inhaled"
ITEM.duration = 100
ITEM.price = 20
ITEM.attribBoosts = {
	["end"] = -2,
	["stm"] = 3,
}

local effectText = {
	"You feel very alert yet paranoid and aggressive.",
}
ITEM:hook("_use", function(item)
	item.player:EmitSound("items/battery_pickup.wav")
	item.player:ChatPrint(table.Random(effectText))
	item.player:ScreenFade(1, Color(255, 255, 255, 255), 3, 0)
end)