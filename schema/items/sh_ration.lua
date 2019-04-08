ITEM.name = "Ration Pack"
ITEM.desc = "A small package that contains food and water"
ITEM.model = "models/props_junk/cardboard_box004a.mdl"
ITEM.width = 1
ITEM.height = 1

ITEM.functions.Open = {
	icon = "icon16/briefcase.png",
	sound = "physics/cardboard/cardboard_box_break1.wav",
	onRun = function(item)
		local client = item.player
		local position = client:getItemDropPos()
		local char = client:getChar()
		local inventory = char:getInv()
		local odds = math.random(0,100)
		local odds2 = math.random(0,100)
			
			if(odds >=40) then
				client:UpdateInv("beans")
			elseif(odds >=20) then
				client:UpdateInv("rat")
			else
				client:UpdateInv("mushroom")
		end
			
			if(odds >=90) then
				client:UpdateInv("tea")
			elseif(odds >=40) then
				client:UpdateInv("water")
			else
				client:UpdateInv("dirtywater")
		end
	end
}