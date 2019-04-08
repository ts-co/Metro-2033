ITEM.name = "Fourth Reich Scout Uniform"
ITEM.desc = "A set of gear and clothing that is worn by scouts of the Fourth Reich"
ITEM.price = 100
ITEM.model = "models/arx/reich/reich_soldier_16.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-200, 0.77698647975922, 48.242790222168),
	ang = Angle(0, -0, 0),
	fov = 11.789551553782,
}

ITEM.replacements = {

{"models/ninja/signalvariance/act_middle_revolyucioner_a3.mdl", "models/arx/reich/reich_soldier_16.mdl"},
{"models/ninja/signalvariance/act_middle_revolyucioner_artyom.mdl", "models/arx/reich/reich_soldier_17.mdl"},
{"models/ninja/signalvariance/act_middle_revolyucioner_bf4.mdl", "models/arx/reich/reich_soldier_16.mdl"},
{"models/ninja/signalvariance/act_middle_revolyucioner_hunter.mdl", "models/cultist_kun/nazi_sol.mdl"},

}

-- If the player has a model that is none of the above then change model to models/arx/reich/reich_soldier_16.mdl

ITEM.Category = "clothing"
function ITEM:onGetDropModel(item) return "models/props_c17/SuitCase_Passenger_Physics.mdl" end