ITEM.name = "Fourth Reich Sniper Uniform"
ITEM.desc = "A set of gear and clothing that is worn by snipers of the Fourth Reich"
ITEM.price = 100
ITEM.model = "models/cultist_kun/nazi_sniper.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-200, 0.77698647975922, 48.242790222168),
	ang = Angle(0, -0, 0),
	fov = 11.789551553782,
}

ITEM.replacements = "models/cultist_kun/nazi_sniper.mdl"

ITEM.Category = "clothing"
function ITEM:onGetDropModel(item) return "models/props_c17/SuitCase_Passenger_Physics.mdl" end