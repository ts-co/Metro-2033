PLUGIN.name = "Metro Effects"
PLUGIN.author = "Pilot"
PLUGIN.desc = "Various effects for immersion."

local footstepList = {
	{"models/arx/hanza/hanza_soldier_1.mdl", "Medium"},
	{"models/arx/hanza/hanza_soldier_2.mdl", "Medium"},
	{"models/arx/hanza/hanza_soldier_3.mdl", "Medium"},
	{"models/arx/hanza/hanza_soldier_4.mdl", "Medium"},
	{"models/arx/hanza/hanza_soldier_5.mdl", "Medium"},
	{"models/arx/neutral/hazmat.mdl", "Heavy"},
	{"models/arx/neutral/hazmat_2.mdl", "Heavy"},
	{"models/arx/neutral/hazmat_3.mdl", "Heavy"},
	{"models/arx/neutral/hazmat_4.mdl", "Heavy"},
	{"models/arx/neutral/medic.mdl", "Heavy"},
	{"models/arx/neutral/medic2.mdl", "Heavy"},
	{"models/arx/neutral/medicshapka.mdl", "Heavy"},
	{"models/arx/neutral/new_medic01.mdl", "Heavy"},
	{"models/arx/neutral/new_medic02.mdl", "Heavy"},
	{"models/arx/neutral/new_medic03.mdl", "Heavy"},
	{"models/arx/neutral/security_station_v1.mdl", "Medium"},
	{"models/arx/neutral/security_station_v2.mdl", "Medium"},
	{"models/arx/neutral/security_station_v3.mdl", "Medium"},
	{"models/arx/neutral/security_station_v4.mdl", "Medium"},
	{"models/arx/neutral/stalker.mdl", "Light"},
	{"models/arx/redline/red_line_offcier_1.mdl", "Medium"},
	{"models/arx/redline/red_line_offcier_2.mdl", "Medium"},
	{"models/arx/redline/red_line_officer_3.mdl", "Heavy"},
	{"models/arx/redline/red_line_officer_4.mdl", "Light"},
	{"models/arx/redline/red_line_officer_5.mdl", "Light"},
	{"models/arx/redline/red_line_officer_6.mdl", "Heavy"},
	{"models/arx/redline/red_line_soldier_1.mdl", "Medium"},
	{"models/arx/redline/red_line_soldier_2.mdl", "Medium"},
	{"models/arx/redline/red_line_soldier_3.mdl", "Light"},
	{"models/arx/redline/red_line_soldier_4.mdl", "Heavy"},
	{"models/arx/redline/red_line_soldier_5.mdl", "Light"},
	{"models/arx/redline/red_line_soldier_6.mdl", "Light"},
	{"models/arx/redline/red_line_soldier_7.mdl", "Medium"},
	{"models/arx/redline/red_line_soldier_8.mdl", "Medium"},
	{"models/arx/redline/red_line_soldier_9.mdl", "Medium"},
	{"models/arx/redline/red_line_soldier_10.mdl", "Medium"},
	{"models/arx/redline/red_line_soldier_11.mdl", "Medium"},
	{"models/arx/redline/red_line_soldier_12.mdl", "Medium"},
	{"models/arx/redline/red_line_soldier_13.mdl", "Medium"},
	{"models/arx/redline/red_line_soldier_14.mdl", "Medium"},
	{"models/arx/redline/red_line_soldier_15.mdl", "Medium"},
	{"models/arx/redline/red_line_soldier_16.mdl", "Medium"},
	{"models/arx/redline/red_line_soldier_17.mdl", "Heavy"},
	{"models/arx/redline/red_line_soldier_18.mdl", "Heavy"},
	{"models/arx/redline/red_line_soldier_19.mdl", "Heavy"},
	{"models/arx/redline/red_line_soldier_20.mdl", "Light"},
	{"models/arx/redline/red_line_spy.mdl", "Light"},
	{"models/arx/reich/reich_officer_1.mdl", "Medium"},
	{"models/arx/reich/reich_officer_2.mdl", "Light"},
	{"models/arx/reich/reich_soldier_1.mdl", "Medium"},
	{"models/arx/reich/reich_soldier_2.mdl", "Medium"},
	{"models/arx/reich/reich_soldier_3.mdl", "Medium"},
	{"models/arx/reich/reich_soldier_4.mdl", "Medium"},
	{"models/arx/reich/reich_soldier_5.mdl", "Medium"},
	{"models/arx/reich/reich_soldier_6.mdl", "Medium"},
	{"models/arx/reich/reich_soldier_7.mdl", "Medium"},
	{"models/arx/reich/reich_soldier_8.mdl", "Medium"},
	{"models/arx/reich/reich_soldier_9.mdl", "Medium"},
	{"models/arx/reich/reich_soldier_10.mdl", "Medium"},
	{"models/arx/reich/reich_soldier_11.mdl", "Medium"},
	{"models/arx/reich/reich_soldier_12.mdl", "Medium"},
	{"models/arx/reich/reich_soldier_13.mdl", "Medium"},
	{"models/arx/reich/reich_soldier_14.mdl", "Medium"},
	{"models/arx/reich/reich_soldier_15.mdl", "Medium"},
	{"models/arx/reich/reich_soldier_16.mdl", "Medium"},
	{"models/arx/reich/reich_soldier_17.mdl", "Medium"},
	{"models/arx/reich/reich_soldier_18.mdl", "Medium"},
	{"models/arx/reich/reich_soldier_19.mdl", "Medium"},
	{"models/ninja/signalvariance/act_digger_a3.mdl", "Light"},
	{"models/ninja/signalvariance/act_digger_artyom.mdl", "Light"},
	{"models/ninja/signalvariance/act_digger_bf4.mdl", "Light"},
	{"models/ninja/signalvariance/act_digger_hunter.mdl", "Light"}


}

local footstepType = {}
footstepType["Light"] = {"NPC_MetroPolice.FootstepLeft", "NPC_MetroPolice.FootstepRight"}
footstepType["Medium"] = {"NPC_CombineS.RunFootstepLeft", "NPC_CombineS.RunFootstepRight"}
footstepType["Heavy"] = {"NPC_MetroPolice.RunFootstepLeft", "NPC_MetroPolice.RunFootstepRight"}

function PLUGIN:PlayerFootstep(client, ps, foot, footSound, volume, rf)
	if (client:isRunning()) then
		for k, v in pairs(footstepList) do
			if client:GetModel() == v[1] then
				for k2, v2 in pairs(footstepType) do
					if v[2] == k2 then
						if foot == 0 then
							client:EmitSound(v2[1])
						else
							client:EmitSound(v2[2])
						end
					end
				end
				return true
			end
		end
	end
end