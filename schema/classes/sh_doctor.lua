CLASS.name = "Doctor"
CLASS.desc = "A prized profession and honourable in the Metro."
CLASS.faction = FACTION_DWELLER
CLASS.color = Color(126, 80, 21)
CLASS.flag = "D"
CLASS.pay = 6
CLASS.payTime = 3600 --1 hour in seconds

function CLASS:onCanBe(client)
	local character = client:getChar()
	local inventory = character:getInv()

	if character:hasFlags("D") then
		return true
	else
		return false
	end
end

CLASS_DOCTOR = CLASS.index