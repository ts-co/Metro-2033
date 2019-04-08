CLASS.name = "Metro Merchants"
CLASS.desc = "Merchants of the Metro."
CLASS.faction = FACTION_DWELLER
CLASS.color = Color(150, 150, 150)
CLASS.flag = "T"
CLASS.pay = 4
CLASS.payTime = 3600 --1 hour in seconds

function CLASS:onCanBe(client)
	local character = client:getChar()

	if character:hasFlags("T") then
		return true
	else
		return false
	end
end

CLASS_TRADER = CLASS.index