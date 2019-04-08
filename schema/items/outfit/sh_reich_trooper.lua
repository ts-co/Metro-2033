ITEM.name = "Fourth Reich Trooper Uniform"
ITEM.desc = "A set of gear and clothing that is worn by troopers of the Fourth Reich" 
ITEM.price = 100
ITEM.model = "models/arx/reich/reich_soldier_10.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-200, 0.77698647975922, 48.242790222168),
	ang = Angle(0, -0, 0),
	fov = 11.789551553782,
}

ITEM.replacements = {

{"models/ninja/signalvariance/act_middle_revolyucioner_a3.mdl", "models/arx/reich/reich_soldier_10.mdl"},
{"models/ninja/signalvariance/act_middle_revolyucioner_artyom.mdl", "models/arx/reich/reich_soldier_18.mdl"},
{"models/ninja/signalvariance/act_middle_revolyucioner_bf4.mdl", "models/arx/reich/reich_soldier_8.mdl"},
{"models/ninja/signalvariance/act_middle_revolyucioner_hunter.mdl", "models/arx/reich/reich_soldier_9.mdl"},

}

-- If the player has a model that is none of the above then change model to models/arx/reich/reich_soldier_10.mdl

ITEM.Category = "clothing"
function ITEM:onGetDropModel(item) return "models/props_c17/SuitCase_Passenger_Physics.mdl" end