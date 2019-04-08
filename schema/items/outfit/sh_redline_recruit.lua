ITEM.name = "Red Line Recruit Uniform"
ITEM.desc = "A set of clothing that is worn by recruits in the Red Line" 
ITEM.price = 100
ITEM.model = "models/devcon/mrp/act/redline_soldier.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-200, 0.77698647975922, 48.242790222168),
	ang = Angle(0, -0, 0),
	fov = 11.789551553782,
}

ITEM.replacements = {

{"models/ninja/signalvariance/act_middle_revolyucioner2_a3.mdl", "models/ninja/signalvariance/act_digger_a3.mdl"},
{"models/ninja/signalvariance/act_middle_revolyucioner2_artyom.mdl", "models/ninja/signalvariance/act_digger_artyom.mdl"},
{"models/ninja/signalvariance/act_middle_revolyucioner2_bf4.mdl", "models/ninja/signalvariance/act_digger_bf4.mdl"},
{"models/ninja/signalvariance/act_middle_revolyucioner2_hunter.mdl", "models/ninja/signalvariance/act_digger_hunter.mdl"},

}

-- If the player has a model that is none of the above then change model to models/devcon/mrp/act/redline_soldier.mdl

ITEM.Category = "clothing"
function ITEM:onGetDropModel(item) return "models/props_c17/SuitCase_Passenger_Physics.mdl" end