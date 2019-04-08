CLASS.name = "Hanseatic League"
CLASS.desc = "An economic and militaristic powerhouse."
CLASS.faction = FACTION_DWELLER
CLASS.color = Color(255, 128, 0)
CLASS.flag = "H"
CLASS.pay = 7
CLASS.payTime = 3600 --1 hour in seconds

function CLASS:onCanBe(client)
	local character = client:getChar()
	local inventory = character:getInv()

	if inventory:hasItem("hanzapassport") and character:hasFlags("H") then
		return true
	else
		return false
	end
end

CLASS_HANZA = CLASS.index