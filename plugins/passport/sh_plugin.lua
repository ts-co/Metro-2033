PLUGIN.name = "Passports New"
PLUGIN.author = "Pilot"
PLUGIN.desc = "Adds passports that contain char information"

nut.util.include("cl_write.lua")

if (SERVER) then
	util.AddNetworkString("nutMetroPassportWrite")
	util.AddNetworkString("nutMetroPassportSend")
	util.AddNetworkString("nutMetroPassportRead")
	util.AddNetworkString("OpenPassport")
end