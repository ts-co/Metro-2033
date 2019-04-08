ITEM.name = "Red Line Officer Uniform"
ITEM.desc = "A set of clothing that is worn by officers of the Red Line" 
ITEM.price = 100
ITEM.model = "models/arx/redline/red_line_officer_4.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-200, 0.77698647975922, 48.242790222168),
	ang = Angle(0, -0, 0),
	fov = 11.789551553782,
}

ITEM.replacements = {

{"models/ninja/signalvariance/act_middle_revolyucioner2_a3.mdl", "models/arx/redline/red_line_offcier_1.mdl"},
{"models/ninja/signalvariance/act_middle_revolyucioner2_artyom.mdl", "models/cultist_kun/red_off.mdl"},
{"models/ninja/signalvariance/act_middle_revolyucioner2_bf4.mdl", "models/devcon/mrp/act/redline_co.mdl"},
{"models/ninja/signalvariance/act_middle_revolyucioner2_hunter.mdl", "models/cultist_kun/red_off2.mdl"},

}

-- If the player has a model that is none of the above then change model to models/arx/redline/red_line_officer_4.mdl

ITEM.Category = "clothing"
function ITEM:onGetDropModel(item) return "models/props_c17/SuitCase_Passenger_Physics.mdl" end