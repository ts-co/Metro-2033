PLUGIN.name = "Languages"
PLUGIN.author = "Pilot"
PLUGIN.desc = "Allows players to speak in different languages."

--[[
The language you want can be found here:
https://sites.google.com/site/tomihasa/google-language-codes
--]]

--command, language code
nut.talk.add("german", "de")
nut.talk.add("finnish", "fi")
nut.talk.add("french", "fr")
nut.talk.add("italian", "it")
nut.talk.add("chinese", "zh_CN")

nut.command.add("langgive", {
	adminOnly = true,
	syntax = "<string name> [string lang]",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target) and target:getChar()) and (nut.talk.list[arguments[2]]) then
			target:getChar():giveTalks(arguments[2])
			nut.util.notifyLocalized("talkGive", nil, client:Name(), arguments[2], target:Name())
		elseif not nut.talk.list[arguments[2]] then
			client:notifyLocalized(arguments[2].." does not exist.")
		end
	end
})

nut.command.add("langtake", {
	adminOnly = true,
	syntax = "<string name> [string flags]",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target) and target:getChar()) then
			target:getChar():takeTalks(arguments[2])
			nut.util.notifyLocalized("talkTake", nil, client:Name(), arguments[2], target:Name())
		end
	end
})

for command, lang in pairs(nut.talk.list) do
	nut.chat.register(command, {
		onChatAdd = function(speaker, text)
			local httpText = string.gsub(text, "%s", "+")
			http.Fetch("https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl="..lang.code.."&dt=t&q="..httpText,
			function(resp, len, headers)
				local jsn = util.JSONToTable(resp)
				if LocalPlayer():getChar():hasTalks(command) then
					chat.AddText(nut.config.get("chatColor"), speaker:getChar():getName().." says ".."''"..text.."''")
				else
					chat.AddText(nut.config.get("chatColor"), speaker:getChar():getName().." says ".."''"..jsn[1][1][1].."''")
				end
			end,
			function(error)
				print(error)
			end)
		end,
		onCanSay = function(speaker)
			return speaker:getChar():hasTalks(command)
		end,
		prefix = {"/"..command}
	})
end