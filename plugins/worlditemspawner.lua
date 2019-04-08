local PLUGIN = PLUGIN
PLUGIN.name = "World Item Spawner"
PLUGIN.author = "Black Tea (NS 1.0), Neon (NS 1.1)"
PLUGIN.desc = "World Item Spawner."
PLUGIN.itempoints = PLUGIN.itempoints or {}

PLUGIN.spawngroups = {
	["junk"] = {
{"battery"},
{"book01"},
{"book02"},
{"book03"},
{"bowl"},
{"brick"},
{"brokeradio"},
{"bucket"},
{"can"},
{"carton"},
{"chemicals"},
{"clock"},
{"doll"},
{"doll2"},
{"door"},
{"emptybottle"},
{"emptytincan"},
{"engine01"},
{"engine02"},
{"fan"},
{"flowerpot"},
{"frame"},
{"gasoline"},
{"globe"},
{"headset"},
{"hula"},
{"jar"},
{"jerrycan"},
{"kettle"},
{"keyboard"},
{"lamp"},
{"lampshade"},
{"laptop"},
{"lightbulb"},
{"mgrmag"},
{"monitor01"},
{"monitor02"},
{"monitor03"},
{"mug"},
{"nails"},
{"newspaper"},
{"paint"},
{"pan"},
{"pc01"},
{"pc02"},
{"phone"},
{"plasticbottle01"},
{"plasticbottle02"},
{"plasticbottle03"},
{"plasticbucket"},
{"plasticjug"},
{"plate"},
{"pliers"},
{"pot"},
{"pot2"},
{"propane"},
{"shoe"},
{"skull"},
{"teapot"},
{"tin"},
{"tin2"},
{"tire"},
{"toy01"},
{"toy02"},
{"toy03"},
{"trafficcone"},
{"wrench"},
{"mysterytape01"}, -- Tapes
{"mysterytape02"},
{"mysterytape03"},

	},

	["rare"] = {
{"darkgirl"},
{"eaglet"},
{"katyusha"},
{"leninsspeechwhatissovietpower"},
{"metroblues"},
{"nazimegaphone"},
{"redflag"},
{"riga"},
{"sovietanthem"},
{"stalinspeech1941"},
{"theinternational"},
{"thewarsawian"},
{"workersmarseillaise"},
{"flashlight"},
{"gasmask"},
{"gasmask2"},
{"gasmfilter"},
{"map"},
{"ration"},
{"beans"},
{"bible"},
{"communistmanifesto"},
{"beer"},
{"moonshine"},
{"vodka"},
{"whiskey"},
{"wine"},
{"backpack"},
{"bandage"},
{"medkit"},
{"axe"},
{"crowbar"},
{"hammer"},
{"pipe"},
{"shovel"},
{"flare"},
{"battery"}, -- Junk Filler
{"book01"},
{"book02"},
{"book03"},
{"brokeradio"},
{"clock"},
{"doll"},
{"emptybottle"},
{"engine01"},
{"engine02"},
{"fan"},
{"jerrycan"},
{"kettle"},
{"keyboard"},
{"lamp"},
{"laptop"},
{"lightbulb"},
{"mgrmag"},
{"monitor01"},
{"monitor02"},
{"monitor03"},
{"mug"},
{"nails"},
{"paint"},
{"pan"},
{"pc01"},
{"pc02"},
{"pliers"},
{"propane"},
{"shoe"},
{"skull"},
{"tire"},
{"toy01"},
{"toy02"},
{"toy03"},
{"wrench"},
{"plasticbottle01"},
{"plasticbottle02"},
{"plasticbottle03"},

	},
	
	["camp"] = {
{"dirtywater"},
{"water"},
{"beans"},
{"rat"},
{"mushroom"},
{"humanflesh"},
{"mgrmag"},
{"moonshine"},
{"beer"},
{"vodka"},
{"whiskey"},
{"bandage"},
{"riga"},
{"metroblues"},
{"katyusha"},
{"map"},
{"satchel"},
{"emptybottle"}, -- Junk Filler
{"plate"},
{"pot"},
{"pot2"},
{"shoe"},
{"skull"},
{"teapot"},
{"tin"},
{"tin2"},
{"toy01"},
{"doll"},
{"doll2"},
{"emptytincan"},
{"flare"},

	},
}
	

PLUGIN.spawnrate = 2580 -- Every 43 minutes it will attempt to spawn new loot
PLUGIN.maxitems = 40
PLUGIN.itemsperspawn = 1
PLUGIN.spawneditems = PLUGIN.spawneditems or {}

if SERVER then
	local spawntime = 1

	function PLUGIN:ItemShouldSave(entity)
		return (!entity.generated)
	end

	function PLUGIN:Think()
		if spawntime > CurTime() then return end
		spawntime = CurTime() + self.spawnrate
		for k, v in ipairs(self.spawneditems) do
			if (!v:IsValid()) then
				table.remove(self.spawneditems, k)
			end
		end

		if #self.spawneditems >= self.maxitems then return end

		for i = 1, self.itemsperspawn do
			if #self.spawneditems >= self.maxitems then
					table.remove(self.spawneditems)
				return
			end

			local v = table.Random(self.itempoints)

			if (!v) then
				return
			end


			local data = {}
			data.start = v[1]
			data.endpos = data.start + Vector(0, 0, 1)
			data.filter = client
			data.mins = Vector(-16, -16, 0)
			data.maxs = Vector(16, 16, 16)
			local trace = util.TraceHull(data)

			if trace.Entity:IsValid() then
				continue
			end

			local idat = table.Random(self.spawngroups[v[2]]) or self.spawngroup["default"]
			nut.item.spawn(idat[1], v[1] + Vector( math.Rand(-8,8), math.Rand(-8,8), 10 ), nil, AngleRand(), idat[2] or {})
		end
	end

	function PLUGIN:LoadData()
		self.itempoints = self:getData() or {}
	end

	function PLUGIN:SaveData()
		self:setData(self.itempoints)
	end

else

	netstream.Hook("nut_DisplaySpawnPoints", function(data)
		for k, v in pairs(data) do
			local emitter = ParticleEmitter( v[1] )
			local smoke = emitter:Add( "sprites/glow04_noz", v[1] )
			smoke:SetVelocity( Vector( 0, 0, 1 ) )
			smoke:SetDieTime(10)
			smoke:SetStartAlpha(255)
			smoke:SetEndAlpha(255)
			smoke:SetStartSize(64)
			smoke:SetEndSize(64)
			smoke:SetColor(255,186,50)
			smoke:SetAirResistance(300)
		end
	end)

end

nut.command.add("itemspawnadd", {
	adminOnly = true,
	syntax = "<junk/rare/camp>",
	onRun = function(client, arguments)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local spawngroup = arguments[1] or "default"
		table.insert( PLUGIN.itempoints, { hitpos, spawngroup } )
		client:notify( "You added ".. spawngroup .. " item spawner." )
	end
})

nut.command.add("itemspawnremove", {
	adminOnly = true,
	onRun = function(client, arguments)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local range = arguments[1] or 128
		local mt = 0
		for k, v in pairs( PLUGIN.itempoints ) do
			local distance = v[1]:Distance( hitpos )
			if distance <= tonumber(range) then
				PLUGIN.itempoints[k] = nil
				mt = mt + 1
			end
		end
		client:notify( mt .. " item spawners has been removed.")
	end
})

nut.command.add("itemspawndisplay", {
	superAdminOnly = true,
	onRun = function(client, arguments)
		if SERVER then
			netstream.Start(client, "nut_DisplaySpawnPoints", PLUGIN.itempoints)
			client:notify( "Displayed All Points for 10 secs." )
		end
	end
})