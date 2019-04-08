ITEM.name = "Marijuana"
ITEM.model = "models/katharsmodels/contraband/zak_wiet/zak_wiet.mdl"
ITEM.desc = "A Psychoactive drug that's smoked"
ITEM.duration = 200
ITEM.price = 40
ITEM.attribBoosts = {
	["end"] = 2,
	["stm"] = -1,
}

local effectText = {
	"As soon as you inhale you feel a sense of euphoria, you begin to feel relaxed.",
}
ITEM:hook("_use", function(item)
	item.player:EmitSound("items/battery_pickup.wav")
	item.player:ChatPrint(table.Random(effectText))
	item.player:ScreenFade(1, Color(255, 255, 255, 255), 3, 0)
end)