ITEM.name = "Veteran Bandit Outfit"
ITEM.desc = "A black trench coat, a pair of trousers, shoes, gloves and a balaclava are all inside"
ITEM.price = 100
ITEM.model = "models/stalkertnb/banditboss1.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-200, 0.77698647975922, 48.242790222168),
	ang = Angle(0, -0, 0),
	fov = 11.789551553782,
}

ITEM.replacements = "models/stalkertnb/banditboss1.mdl"
ITEM.Category = "clothing"

function ITEM:onGetDropModel(item) return "models/props_c17/SuitCase_Passenger_Physics.mdl" end