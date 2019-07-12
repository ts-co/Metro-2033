SCHEMA.name = "Metro 2033"
SCHEMA.author = "Pilot & Dickmosi"
SCHEMA.desc = "Serious Roleplay"

--USE THIS COLLECTION: https://steamcommunity.com/sharedfiles/filedetails/?id=1619229510

nut.currency.set("", "bullet", "bullets")

--Serverside

--Clientside

--Shared
nut.util.include("sh_chatprefixes.lua")
nut.util.include("sh_commands.lua")

--Directory
nut.util.includeDir("meta", nil, true)
nut.util.includeDir("hooks")

SCHEMA:DisablePlugin("storage")
SCHEMA:DisablePlugin("camera")

if (SERVER) then

--  Fonts
	resource.AddFile( "resource/fonts/TravelingTypewriter.ttf" )
	resource.AddFile( "resource/fonts/Bentosa.ttf")
	resource.AddFile( "resource/fonts/BEBAS.ttf" )

-- Passport Materials
	resource.AddFile( "materials/vgui/passports/passport_blank.png" )
	resource.AddFile( "materials/vgui/passports/passport_hanza.png" )
	resource.AddFile( "materials/vgui/passports/passport_militia.png" )
	resource.AddFile( "materials/vgui/passports/passport_redline.png" )
	resource.AddFile( "materials/vgui/passports/passport_reich.png" )
	
-- Misc Gamemode Content
	resource.AddFile( "materials/icon16/eat.png" )
	resource.AddFile( "sound/dickmosi/eat.wav" )
	
-- Cassette Content
	resource.AddFile("sound/cassettes/DarkGirl.mp3")
	resource.AddFile("sound/cassettes/Eaglet.mp3")
	resource.AddFile("sound/cassettes/LeninsSpeechWhatIsSovietPower.mp3")
	resource.AddFile("sound/cassettes/RedFlag.mp3")
	resource.AddFile("sound/cassettes/SovietAnthem.mp3")
	resource.AddFile("sound/cassettes/StalinSpeech1941.mp3")
	resource.AddFile("sound/cassettes/TheInternational.mp3")
	resource.AddFile("sound/cassettes/TheWarsawian.mp3")
	resource.AddFile("sound/cassettes/WorkersMarseillaise.mp3")

end

nut.flag.add("R", "Access to joining the Red Line.")
nut.flag.add("F", "Access to joining the Fourth Reich.")
nut.flag.add("H", "Access to joining the Hanseatic League.")
nut.flag.add("L", "Access to joining the Leninsky Prospekt Militia.")
nut.flag.add("M", "Access to joining the Mutant Creatures.")
nut.flag.add("S", "Access to joining the Golden Snakes.")
nut.flag.add("T", "Access to joining the Metro Merchants.")

nut.flag.add("B", "Access to becoming a Bartender.")
nut.flag.add("D", "Access to becoming a Doctor.")
nut.flag.add("V", "Access to becoming a Vagrant (No Salary.)")

-- Auto-reload support for class pay timers.
for index, class in ipairs(nut.class.list) do
	for k, v in ipairs(team.GetPlayers(index)) do
		if (class.pay and class.pay > 0) then
			timer.Adjust("nutSalary"..v:UniqueID(), class.payTime or 300, 0, function()
				local pay = hook.Run("GetSalaryAmount", v, class) or class.pay

				v:getChar():giveMoney(pay)
				v:notifyLocalized("salary", nut.currency.get(pay))
			end)
		else
			timer.Remove("nutSalary"..v:UniqueID())
		end
	end
end
