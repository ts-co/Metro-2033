ITEM.name = "Novice Stalker Outfit"
ITEM.desc = "A set of gear and clothing that is worn by Novice Stalkers"
ITEM.price = 100
ITEM.model = "models/devcon/mrp/act/stalker_novice.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-200, 0.77698647975922, 48.242790222168),
	ang = Angle(0, -0, 0),
	fov = 11.789551553782,
}

ITEM.replacements = "models/devcon/mrp/act/stalker_novice.mdl"
ITEM.Category = "clothing"

function ITEM:onGetDropModel(item) return "models/props_c17/SuitCase_Passenger_Physics.mdl" end