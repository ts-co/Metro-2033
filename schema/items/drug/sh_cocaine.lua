ITEM.name = "Cocaine"
ITEM.model = "models/srcocainelab/ziplockedcocaine.mdl"
ITEM.desc = "A highly addictive drug that's inhaled"
ITEM.duration = 100
ITEM.price = 50
ITEM.attribBoosts = {
	["stm"] = 4,
}

local effectText = {
	"As you inhale you feel begin to feel euphoric, more agile and better about yourself.",
}
ITEM:hook("_use", function(item)
	item.player:EmitSound("items/battery_pickup.wav")
	item.player:ChatPrint(table.Random(effectText))
	item.player:ScreenFade(1, Color(255, 255, 255, 255), 3, 0)
end)