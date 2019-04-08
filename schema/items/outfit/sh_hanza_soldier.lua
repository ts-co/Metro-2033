ITEM.name = "Hanza Soldier Uniform"
ITEM.desc = "A set of gear and clothing that is worn by soldiers of the Hanza" 
ITEM.price = 100
ITEM.model = "models/arx/hanza/hanza_soldier_3.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-200, 0.77698647975922, 48.242790222168),
	ang = Angle(0, -0, 0),
	fov = 11.789551553782,
}

ITEM.replacements = {

{"models/ninja/signalvariance/act_fedor_burbon_a3.mdl", "models/arx/hanza/hanza_soldier_1.mdl"},
{"models/ninja/signalvariance/act_fedor_burbon_artyom.mdl", "models/arx/hanza/hanza_soldier_3.mdl"},
{"models/ninja/signalvariance/act_fedor_burbon_bf4.mdl", "models/arx/hanza/hanza_soldier_4.mdl"},
{"models/ninja/signalvariance/act_fedor_burbon_hunter.mdl", "models/arx/hanza/hanza_soldier_2.mdl"},

}

-- If the player has a model that is none of the above then change model to models/arx/hanza/hanza_soldier_3.mdl


ITEM.Category = "clothing"
function ITEM:onGetDropModel(item) return "models/props_c17/SuitCase_Passenger_Physics.mdl" end