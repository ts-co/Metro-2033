CLASS.name = "Golden Snakes"
CLASS.desc = "A small group of bandits looking to cause trouble."
CLASS.faction = FACTION_DWELLER
CLASS.color = Color(126, 80, 21)
CLASS.flag = "S"
CLASS.pay = 5
CLASS.payTime = 3600 --1 hour in seconds

function CLASS:onCanBe(client)
	local character = client:getChar()
	local inventory = character:getInv()

	if character:hasFlags("S") then
		return true
	else
		return false
	end
end

CLASS_SNAKES = CLASS.index