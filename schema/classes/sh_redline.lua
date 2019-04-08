CLASS.name = "Red Line"
CLASS.desc = "The largest Communist army in the Metro."
CLASS.faction = FACTION_DWELLER
CLASS.color = Color(255, 0, 0, 255)
CLASS.flag = "R"
CLASS.pay = 7
CLASS.payTime = 3600 --1 hour in seconds

function CLASS:onCanBe(client)
	local character = client:getChar()
	local inventory = character:getInv()

	if inventory:hasItem("redlinepassport") and character:hasFlags("R") then
		return true
	else
		return false
	end
end

CLASS_REDLINE = CLASS.index