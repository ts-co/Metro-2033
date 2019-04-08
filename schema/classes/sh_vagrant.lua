CLASS.name = "Vagrant"
CLASS.desc = "You are a vagrant, you have no home or fixed job (No Salary.)"
CLASS.faction = FACTION_DWELLER
CLASS.color = Color(126, 80, 21)
CLASS.flag = "V"
CLASS.pay = 1
CLASS.payTime = 144000 -- 40 Hours in Seconds

function CLASS:onCanBe(client)
	local character = client:getChar()
	local inventory = character:getInv()

	if character:hasFlags("V") then
		return true
	else
		return false
	end
end

CLASS_VAGRANT = CLASS.index