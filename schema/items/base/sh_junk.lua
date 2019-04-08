ITEM.name = "base junk"
ITEM.desc = "uh oh"
ITEM.category = "Junk"
ITEM.model = "models/weapons/w_package.mdl"
ITEM.money = {1, 1}
ITEM.width = 1
ITEM.height = 1

ITEM.functions._scrap = {
	name = "Scrap",
	tip = "Converts the item into Money",
	icon = "icon16/arrow_refresh.png",
	onRun = function(item)
		local position = item.player:getItemDropPos()
		local client = item.player
		local amount = (math.random(item.money[1], item.money[2]))
		
		item.player:EmitSound("npc/manhack/grind"..math.random(1,5)..".wav", 70)
		nut.util.Notify("You have received "..nut.currency.GetName(amount).." for scrapping this item.", client)
		client:GiveMoney(amount)
	end
}