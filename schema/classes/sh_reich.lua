CLASS.name = "Fourth Reich"
CLASS.desc = "An army ruled by a facist dictator."
CLASS.faction = FACTION_DWELLER
CLASS.color = Color(0, 155, 0)
CLASS.flag = "F"
CLASS.pay = 7
CLASS.payTime = 3600 --1 hour in seconds

function CLASS:onCanBe(client)
	local character = client:getChar()
	local inventory = character:getInv()

	if inventory:hasItem("reichpassport") and character:hasFlags("F") then
		return true
	else
		return false
	end
end

CLASS_REICH = CLASS.index