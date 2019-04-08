function SCHEMA:LoadFonts(font, genericFont)
	surface.CreateFont("nutWhisperFont", {
		font = genericFont,
		size = 13,
		weight = 1000,
		extend = true
	})

	surface.CreateFont("nutYellFont", {
		font = genericFont,
		size = 30,
		weight = 1000,
		extend = true
	})
end

-- Add the default chat types here.
do
	-- Load the chat types after the configs so we can access changed configs.
	hook.Add("InitializedConfig", "nutChatTypes", function()
		-- The default in-character chat.
		nut.chat.register("ic", {
			format = "%s says, \"%s\"",
			onGetColor = function(speaker, text)
				-- If you are looking at the speaker, make it greener to easier identify who is talking.
				if (LocalPlayer():GetEyeTrace().Entity == speaker) then
					return nut.config.get("chatListenColor")
				end

				-- Otherwise, use the normal chat color.
				return nut.config.get("chatColor")
			end,
			onCanHear = nut.config.get("chatRange", 280)
		})

		-- Actions and such.
		nut.chat.register("menear", {
			format = "**%s %s",
			onGetColor = nut.chat.classes.ic.onGetColor,
			onCanHear = nut.config.get("chatRange", 280) * 0.25,
			prefix = {"/menear", "/actionnear"},
			font = "nutChatFontItalics",
			filter = "actions",
			deadCanChat = true
		})

		nut.chat.register("me", {
			format = "**%s %s",
			onGetColor = nut.chat.classes.ic.onGetColor,
			onCanHear = nut.config.get("chatRange", 280),
			prefix = {"/me", "/action"},
			font = "nutChatFontItalics",
			filter = "actions",
			deadCanChat = true
		})

		nut.chat.register("mefar", {
			format = "**%s %s",
			onGetColor = nut.chat.classes.ic.onGetColor,
			onCanHear = nut.config.get("chatRange", 280) * 2,
			prefix = {"/mefar", "/actionfar"},
			font = "nutChatFontItalics",
			filter = "actions",
			deadCanChat = true
		})

		-- Actions and such.
		nut.chat.register("itnear", {
			onChatAdd = function(speaker, text)
				chat.AddText(nut.config.get("chatColor"), "**"..text)
			end,
			onCanHear = nut.config.get("chatRange", 280) * 0.25,
			prefix = {"/itnear"},
			font = "nutChatFontItalics",
			filter = "actions",
			deadCanChat = true
		})

		nut.chat.register("it", {
			onChatAdd = function(speaker, text)
				chat.AddText(nut.config.get("chatColor"), "**"..text)
			end,
			onCanHear = nut.config.get("chatRange", 280),
			prefix = {"/it"},
			font = "nutChatFontItalics",
			filter = "actions",
			deadCanChat = true
		})

		nut.chat.register("itfar", {
			onChatAdd = function(speaker, text)
				chat.AddText(nut.config.get("chatColor"), "**"..text)
			end,
			onCanHear = nut.config.get("chatRange", 280) * 2,
			prefix = {"/itfar"},
			font = "nutChatFontItalics",
			filter = "actions",
			deadCanChat = true
		})

		-- Whisper chat.
		nut.chat.register("w", {
			format = "%s whispers, \"%s\"",
			onGetColor = function(speaker, text)
				local color = nut.chat.classes.ic.onGetColor(speaker, text)

				-- Make the whisper chat slightly darker than IC chat.
				return Color(color.r - 35, color.g - 35, color.b - 35)
			end,
			onCanHear = nut.config.get("chatRange", 280) * 0.25,
			prefix = {"/w", "/whisper"},
			font = "nutWhisperFont"
		})

		-- Yelling out loud.
		nut.chat.register("y", {
			format = "%s yells, \"%s\"",
			onGetColor = function(speaker, text)
				local color = nut.chat.classes.ic.onGetColor(speaker, text)

				-- Make the yell chat slightly brighter than IC chat.
				return Color(color.r + 35, color.g + 35, color.b + 35)
			end,
			onCanHear = nut.config.get("chatRange", 280) * 2,
			prefix = {"/y", "/yell"},
			font = "nutMediumFont"
			-- font = "nutYellFont"
		})

		-- Out of character.
		local classColor
		nut.chat.register("ooc", {
			onCanSay =  function(speaker, text)
			if (!nut.config.get("allowGlobalOOC")) then
				speaker:notifyLocalized("Global OOC is disabled on this server.")
				return false		
			else
				local delay = nut.config.get("oocDelay", 10)

				-- Only need to check the time if they have spoken in OOC chat before.
				if (delay > 0 and speaker.nutLastOOC) then
					local lastOOC = CurTime() - speaker.nutLastOOC

					-- Use this method of checking time in case the oocDelay config changes.
					if (lastOOC <= delay) then
						speaker:notifyLocalized("oocDelay", delay - math.ceil(lastOOC))

						return false
					end
				end

				-- Save the last time they spoke in OOC.
				speaker.nutLastOOC = CurTime()
			end
			end,
			onChatAdd = function(speaker, text)
				local icon = "icon16/user.png"
				-- man, I did all that works and I deserve differnet icon on ooc chat
				-- if you dont like it
				-- well..
				-- it's on your own.
				if (speaker:SteamID() == "STEAM_0:1:34930764") then -- Chessnut
					icon = "icon16/thumb_down.png"
				elseif (speaker:SteamID() == "STEAM_0:0:19814083") then -- Black Tea the edgiest man
					icon = "icon16/gun.png"
				elseif (speaker:IsSuperAdmin()) then
					icon = "icon16/shield.png"
				elseif (speaker:IsAdmin()) then
					icon = "icon16/star.png"
				elseif (speaker:IsUserGroup("moderator") or speaker:IsUserGroup("operator")) then
					icon = "icon16/wrench.png"
				elseif (speaker:IsUserGroup("vip") or speaker:IsUserGroup("donator") or speaker:IsUserGroup("donor")) then
					icon = "icon16/heart.png"
				end

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)
				local class = nut.class.list[speaker:getChar():getClass()]
				if (class) then
					classColor = class.color
				else
					classColor = team.GetColor(speaker:Team())
				end
				chat.AddText(icon, Color(255, 50, 50), " [OOC] ", classColor, speaker:Name(), color_white, ": "..text)
			end,
			prefix = {"//", "/ooc"},
			noSpaceAfter = true,
			filter = "ooc"
		})

		-- Local out of character.
		nut.chat.register("looc", {
			onCanSay =  function(speaker, text)
				local delay = nut.config.get("loocDelay", 0)

				-- Only need to check the time if they have spoken in OOC chat before.
				if (delay > 0 and speaker.nutLastLOOC) then
					local lastLOOC = CurTime() - speaker.nutLastLOOC

					-- Use this method of checking time in case the oocDelay config changes.
					if (lastLOOC <= delay) then
						speaker:notifyLocalized("loocDelay", delay - math.ceil(lastLOOC))

						return false
					end
				end

				-- Save the last time they spoke in OOC.
				speaker.nutLastLOOC = CurTime()
			end,
			onChatAdd = function(speaker, text)
				chat.AddText(Color(255, 50, 50), "[LOOC] ", nut.config.get("chatColor"), speaker:Name()..": "..text)
			end,
			onCanHear = nut.config.get("chatRange", 280),
			prefix = {".//", "[[", "/looc"},
			noSpaceAfter = true,
			filter = "ooc"
		})

		-- Roll information in chat.
		nut.chat.register("roll", {
			format = "%s has rolled %s",
			color = Color(155, 111, 176),
			filter = "actions",
			font = "nutChatFontItalics",
			onCanHear = nut.config.get("chatRange", 280),
			deadCanChat = true
		})
	end)
end

-- Global events.
nut.chat.register("event", {
	onCanSay =  function(speaker, text)
		return speaker:IsAdmin()
	end,
	onCanHear = 1000000,
	onChatAdd = function(speaker, text)
		chat.AddText(Color(255, 150, 0), text)
	end,
	prefix = {"/event"},
	font = "nutMediumFont"
})