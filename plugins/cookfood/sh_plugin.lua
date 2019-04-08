--VERSION SUPPORT: 1.1-beta

PLUGIN.name = "Cook Food"
PLUGIN.author = "Black Tea"
PLUGIN.desc = "How about getting new foods in NutScript?"

hungrySeconds = 39600 -- 1100 = 300 seconds i guess (3 Hours to Starve)

nut.config.add("hungerTime", 5, "Amount of time between each hunger update." );

COOKLEVEL = {
	[1] = {"cookNever", 2, color_white},
	[2] = {"cookFailed", 1, Color(207, 0, 15)},
	[3] = {"cookWell", 3, Color(235, 149, 50)},
	[4] = {"cookDone", 4, Color(103, 128, 159)},
	[5] = {"cookGood", 6, Color(63, 195, 128)},
}
COOKER_MICROWAVE = 1
COOKER_STOVE = 2

nut.util.include("cl_vgui.lua")

local playerMeta = FindMetaTable("Player")
local entityMeta = FindMetaTable("Entity")

function playerMeta:getHunger()
	return (self:getNetVar("hunger")) or 0
end

function playerMeta:getHungerPercent()
	return math.Clamp(((CurTime() - self:getHunger()) / hungrySeconds), 0, 1)
end

function getPercent(object)
	return math.Clamp(((CurTime() - object:getHunger()) / hungrySeconds), 0, 1)
end

function playerMeta:addHunger(amount)
	local curHunger = CurTime() - self:getHunger()
	self:setNetVar("hunger", 
		CurTime() - math.Clamp(math.min(curHunger, hungrySeconds) - amount, 0, hungrySeconds)
	)
end

function entityMeta:isStove()
	local class = self:GetClass()

	return (class == "nut_stove" or class == "nut_microwave")
end

-- Register HUD Bars.
if (CLIENT) then
	local color = Color(39, 174, 96)

	do
		 nut.bar.add(function()
			return (1 - getPercent(LocalPlayer()))
		end, color, nil, "hunger")
	end

	local hungerBar, percent, wave
	function PLUGIN:Think()
		hungerBar = hungerBar or nut.bar.get("hunger")
		percent = (1 - getPercent(LocalPlayer()))

		if (percent < .33) then -- if hunger is 33%
			wave = math.abs(math.sin(RealTime()*5)*100)

			hungerBar.lifeTime = CurTime() + 1
			hungerBar.color = Color(color.r + wave, color.g - wave, color.b - wave)
		else
			hungerBar.color = color
		end
	end

	local timers = {5, 15, 30}

	netstream.Hook("stvOpen", function(entity, index)
		local inventory = nut.item.inventories[index]
		local inventory2 = LocalPlayer():getChar():getInv()

		nut.gui.inv1 = inventory2:show()
		nut.gui.inv1:ShowCloseButton(true)

		local panel = inventory:show()
		panel:ShowCloseButton(true)
		panel:SetTitle("Stove")
		panel:MoveLeftOf(nut.gui.inv1, 4)
		panel.OnClose = function(this)
			if (IsValid(nut.gui.inv1) and !IsValid(nut.gui.menu)) then
				nut.gui.inv1:Remove()
			end

			netstream.Start("invExit")
		end
			
		function nut.gui.inv1:OnClose()
			if (IsValid(panel) and !IsValid(nut.gui.menu)) then
				panel:Remove()
			end

			netstream.Start("invExit")
		end

		local actPanel = vgui.Create("DPanel")
		actPanel:SetDrawOnTop(true)
		actPanel:SetSize(100, panel:GetTall())
		actPanel.Think = function(this)
			if (!panel or !panel:IsValid() or !panel:IsVisible()) then
				this:Remove()

				return
			end

			local x, y = panel:GetPos()
			this:SetPos(x - this:GetWide() - 5, y)
		end

		for k, v in ipairs(timers) do
			local btn = actPanel:Add("DButton")
			btn:Dock(TOP)
			btn:SetText(v .. " Seconds")
			btn:DockMargin(5, 5, 5, 0)

			function btn.DoClick()
				netstream.Start("stvActive", entity, v)
			end
		end

		nut.gui["inv"..index] = panel
	end)
else
	local PLUGIN = PLUGIN

	function PLUGIN:LoadData()
		if (true) then return end
		
		local savedTable = self:getData() or {}

		for k, v in ipairs(savedTable) do
			local stove = ents.Create(v.class)
			stove:SetPos(v.pos)
			stove:SetAngles(v.ang)
			stove:Spawn()
			stove:Activate()
		end
	end
	
	function PLUGIN:SaveData()
		if (true) then return end

		local savedTable = {}

		for k, v in ipairs(ents.GetAll()) do
			if (v:isStove()) then
				table.insert(savedTable, {class = v:GetClass(), pos = v:GetPos(), ang = v:GetAngles()})
			end
		end

		self:setData(savedTable)
	end
	
	function PLUGIN:CharacterPreSave(character)
		local savedHunger = math.Clamp(CurTime() - character.player:getHunger(), 0, hungrySeconds)
		character:setData("hunger", savedHunger)
	end

	function PLUGIN:PlayerLoadedChar(client, character, lastChar)
		if (character:getData("hunger")) then
			client:setNetVar("hunger", CurTime() - character:getData("hunger"))
		else
			client:setNetVar("hunger", CurTime())
		end
	end

	function PLUGIN:PlayerDeath(client)
		client.refillHunger = true
	end

	function PLUGIN:PlayerSpawn(client)
		if (client.refillHunger) then
			client:setNetVar("hunger", CurTime())
			client.refillHunger = false
		end
	end

	local thinkTime = CurTime()
	function PLUGIN:PlayerPostThink(client)
		if (thinkTime < CurTime()) then
			local percent = (1 - getPercent(client))

			if (percent <= 0) then
				if (client:Alive() and client:Health() <= 0) then
					client:Kill()
				else
					client:SetHealth(math.Clamp(client:Health() - 1, 0, client:GetMaxHealth()))
				end
			end

			thinkTime = CurTime() + nut.config.get("hungerTime")
			--thinkTime = CurTime() + 0.5
		end
	end
end