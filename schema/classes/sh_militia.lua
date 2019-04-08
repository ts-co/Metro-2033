CLASS.name = "Leninsky Prospekt Militia"
CLASS.desc = "An small and nice farming station."
CLASS.faction = FACTION_DWELLER
CLASS.color = Color(0, 102, 255)
CLASS.flag = "L"
CLASS.pay = 7
CLASS.payTime = 3600 --1 hour in seconds

function CLASS:onCanBe(client)
	local character = client:getChar()
	local inventory = character:getInv()

	if inventory:hasItem("leninskypassport") and character:hasFlags("L") then
		return true
	else
		return false
	end
end

CLASS_MILITIA = CLASS.index