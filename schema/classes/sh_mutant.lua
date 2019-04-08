CLASS.name = "Metro Creatures"
CLASS.desc = "Mutants and animals of the Metro."
CLASS.faction = FACTION_DWELLER
CLASS.color = Color(102, 0, 102)
CLASS.flag = "M"
CLASS.pay = 4
CLASS.payTime = 3600 --1 hour in seconds

function CLASS:onCanBe(client)
	local character = client:getChar()

	if character:hasFlags("M") then
		return true
	else
		return false
	end
end

CLASS_MUTANT = CLASS.index