PLUGIN.name = "NPC Item Drop"
PLUGIN.author = "Halokiller38"
PLUGIN.desc = "This plugin makes it when you kill a npc it drops something."

function PLUGIN:OnNPCKilled(entity)
	local class = entity:GetClass()

	if (class == "npc_vj_mutant_nosalis" or class == "npc_vj_mutant_watcher") then
		nut.item.spawn("creaturemeat", entity:GetPos() + Vector(0, 0, 8))
	end
end