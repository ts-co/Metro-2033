PLUGIN.name = "Admin chat"
PLUGIN.author = "Qemist"
PLUGIN.desc = "Adds an admin chat."

local ICON_WRENCH = Material("icon16/wrench.png")
local ICON_STAR = Material("icon16/star.png")
local ICON_SHIELD = Material("icon16/shield.png")
local ICON_DEVELOPER = Material("icon16/wrench_orange.png")

nut.chat.register("adminchat", {
	onChatAdd = function(speaker, text)
		if (speaker:SteamID() == "STEAM_0:1:34930764") then
			icon = ICON_DEVELOPER
		elseif (speaker:IsSuperAdmin()) then
			icon = ICON_SHIELD
		elseif (speaker:IsAdmin()) then
			icon = ICON_STAR
		elseif (speaker:IsUserGroup("operator")) then
			icon = ICON_WRENCH
		end
		--[[
		local override = nut.schema.Call("GetUserIcon", speaker)

		if (override and type(override) != "IMaterial") then
			override = Material(override)
		end

		chat.AddText(override or icon, Color(250, 40, 40), "[ADMIN] ", speaker, color_white, ": "..text)
		--]]
		chat.AddText(icon, Color(250, 40, 40), "[ADMIN] ", speaker, color_white, ": "..text)
	end,
	prefix = {"/admin", "/adminchat"},
	onCanHear = function(speaker, listener)
		return (listener:IsUserGroup("operator") or listener:IsAdmin() or listener:IsSuperAdmin())
	end,
	deadCanChat = true,
	onCanSay = function(speaker)
		if (speaker:IsUserGroup("operator") or speaker:IsAdmin() or speaker:IsSuperAdmin()) then
			return true
		end

		speaker:notifyLocalized(L("no_perm", speaker:Name()), speaker)

		return false
	end
})

nut.chat.register("adminhelp", {
	onChatAdd = function(speaker, text)
		chat.AddText(Color(250, 40, 40), "[HELP] ", speaker, color_white, ": "..text)
	end,
	onSaid = function(speaker, text, listeners)
		local listeners = listeners or {}

		for k,v in pairs(listeners) do
			v:ConCommand("play ambient/alarms/klaxon1.wav")
		end
	end,
	prefix = {"/help", "/adminhelp"},
	onCanHear = function(speaker, listener)
		return (listener:IsUserGroup("operator") or listener:IsAdmin() or listener:IsSuperAdmin())
	end,
	deadCanChat = true,
	onCanSay = function(speaker)
		return true
	end
})