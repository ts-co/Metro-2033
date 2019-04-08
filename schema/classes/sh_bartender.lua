CLASS.name = "Bartender"
CLASS.desc = "A person who serves food and drink."
CLASS.faction = FACTION_DWELLER
CLASS.color = Color(126, 80, 21)
CLASS.flag = "B"
CLASS.pay = 4
CLASS.payTime = 3600 --1 hour in seconds

function CLASS:onCanBe(client)
	local character = client:getChar()
	local inventory = character:getInv()

	if character:hasFlags("B") then
		return true
	else
		return false
	end
end

CLASS_BARTENDER = CLASS.index