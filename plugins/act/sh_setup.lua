local function facingWall(client)
	local data = {}
	data.start = client:GetPos()
	data.endpos = data.start + client:GetAimVector()*54
	data.filter = client

	if (!util.TraceLine(data).HitWorld) then
		return "@faceWall"
	end
end

local function facingWallBack(client)
	local data = {}
	data.start = client:GetPos()
	data.endpos = data.start - client:GetAimVector()*54
	data.filter = client

	if (!util.TraceLine(data).HitWorld) then
		return "@faceWallBack"
	end
end

ACT_ENDSEQ = 0
ACT_STARTSEQ = 1

PLUGIN.acts["sit"] = {
	["citizen_male"] = {sequence = "sit_ground", untimed = true, transition = { [ACT_STARTSEQ] = "idle_to_sit_ground", [ACT_ENDSEQ] = "sit_ground_to_idle" }},
	["citizen_female"] = {sequence = "sit_ground", untimed = true}
}
PLUGIN.acts["sitchair"] = {
	["citizen_male"] = {sequence = {"sit_chair", "sitchair1", "sitchairtable1", "silo_sit", "sitccouchtv1", "sitcouch1"}, untimed = true, transition = { [ACT_STARTSEQ] = "idle_to_sit_chair", [ACT_ENDSEQ] = "sit_chair_to_idle" }},
	["citizen_female"] = {sequence = "sit_chair", untimed = true}
}
PLUGIN.acts["injured"] = {
	["citizen_male"] = {sequence = {"d1_town05_wounded_idle_1", "d1_town05_wounded_idle_2", "d1_town05_winston_down"}, untimed = true},
	["citizen_female"] = {sequence = "d1_town05_wounded_idle_1", untimed = true}
}
PLUGIN.acts["arrest"] = {
	["citizen_male"] = {sequence = "apcarrestidle", untimed = true, onCheck = facingWall}
}
PLUGIN.acts["cheer"] = {
	["citizen_male"] = {sequence = {"cheer1", "cheer2", "wave_smg1"}},
	["citizen_female"] = {sequence = {"cheer1", "wave_smg1"}}
}
PLUGIN.acts["here"] = {
	["citizen_male"] = {sequence = {"wave_close", "wave"}},
	["citizen_female"] = {sequence = {"wave_close", "wave"}}
}
PLUGIN.acts["sitwall"] = {
	["citizen_male"] = {sequence = {"plazaidle4", "injured1"}, untimed = true, onCheck = facingWallBack},
	["citizen_female"] = {sequence = {"plazaidle4", "injured1", "injured2"}, untimed = true, onCheck = facingWallBack}
}
PLUGIN.acts["stand"] = {
	["citizen_male"] = {sequence = {"lineidle01", "lineidle02", "lineidle03", "lineidle04"}, untimed = true},
	["citizen_female"] = {sequence = {"lineidle01", "lineidle02", "lineidle03"}, untimed = true},
	["metrocop"] = {sequence = "plazathreat2", untimed = true}
}
PLUGIN.acts["lean"] = {
	["citizen_male"] = {sequence = "lean_back", untimed = true, onCheck = facingWallBack},
	["citizen_female"] = {sequence = "lean_back", untimed = true, onCheck = facingWallBack}
}