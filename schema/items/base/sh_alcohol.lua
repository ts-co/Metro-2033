ITEM.name = "Based Beer"
ITEM.Desc = "tastes like shit"
ITEM.model = "models/props_junk/glassjug01.mdl"
ITEM.category = "Consumable"

ITEM:hook("_drink", function(item)
	item.player:EmitSound("npc/barnacle/barnacle_gulp1.wav")
end)

ITEM.functions._drink = { 
	name = "Drink",
	tip = "Drink The Alcohol",
	icon = "icon16/drink.png",
	onRun = function(item)
		local client = item.player
		local char = client:getChar()
		if (char and client:Alive()) then
			if (item.attribBoosts) then
				for k, v in pairs(item.attribBoosts) do
					char:addBoost(item.uniqueID, k, v)
				end
			end
			
			local charID = char:getID()
			local name = item.name
			timer.Create("DrinkEffect_" .. item.uniqueID .. "_" .. client:EntIndex(), item.duration, 1, function()
				if (client and IsValid(client)) then
					local curChar = client:getChar()
					if (curChar and curChar:getID() == charID) then
						-- client:notify(Format("%s has worn off.", name))

						if (item.attribBoosts) then
							for k, v in pairs(item.attribBoosts) do
								char:removeBoost(item.uniqueID, k)
							end
						end
					end
				end
			end)
			
			return true
		end

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}