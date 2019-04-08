ITEM.name = "Meat Pile"
ITEM.desc = "A box full of meat with unidentifable animals in it."
ITEM.model = "models/z-o-m-b-i-e/props/wood_box_06.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.price = 30

ITEM.functions.Use = {
	name = "Open",
	icon = "icon16/cursor.png",
	onRun = function(item, player, client)

			item.player:EmitSound("physics/cardboard/cardboard_box_break"..math.random(1,3)..".wav", 75, 200)
				
				local ent = ents.Create("nut_meatpile")
				ent:SetPos(item.player:EyePos() + (item.player:GetAimVector() * 50))
				ent:Spawn()

		return true
	end
}
