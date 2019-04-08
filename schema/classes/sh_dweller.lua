CLASS.name = "Metro Dweller"
CLASS.desc = "Commonfolk of the Metro."
CLASS.faction = FACTION_DWELLER
CLASS.color = Color(126, 80, 21)
CLASS.pay = 4
CLASS.payTime = 3600 --1 hour in seconds

function CLASS:onCanBe(client)
	return true
end

CLASS_DWELLER = CLASS.index