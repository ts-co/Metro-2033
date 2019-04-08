PLUGIN.name = "Cassette Player"
PLUGIN.author = "Pilot"
PLUGIN.desc = "Collect cassette's and listen to your favorite tunes."

if (SERVER) then
	util.AddNetworkString("cOpen")
end

local entityMeta = FindMetaTable("Entity")

function entityMeta:isPlayer()
	local class = self:GetClass()

	return (class == "nut_cassetteplayer")
end

if (CLIENT) then
	net.Receive("cOpen", function(len, client)
		local entity = net.ReadType()
		local index = net.ReadUInt(32)
		local inventory = nut.item.inventories[index]
				local inventory2 = LocalPlayer():getChar():getInv()

				local playerInv = inventory2:show()
				playerInv:SetTitle("Player Inventory")
				playerInv:ShowCloseButton(false)
				
				local cInv = inventory:show()
				cInv:ShowCloseButton(true)
				cInv:SetTitle("")
				cInv:MoveLeftOf(playerInv, 4)
				cInv.OnClose = function(this)
					if (IsValid(playerInv) and !IsValid(nut.gui.menu)) then
						playerInv:Remove()
					end
					
					netstream.Start("invExit")
				end

				local actPanel = vgui.Create("DPanel")
				actPanel:SetDrawOnTop(true)
				actPanel:SetSize(100, cInv:GetTall())
				actPanel.Think = function(this)
					if (!cInv or !cInv:IsValid() or !cInv:IsVisible()) then
						this:Remove()
						return
					end

					local x, y = cInv:GetPos()
					this:SetPos(x - this:GetWide() - 5, y)
				end

				local btnOn = actPanel:Add("DButton")
					btnOn:Dock(TOP)
					btnOn:SetText("Play")
					btnOn:DockMargin(5, 5, 5, 0)
					function btnOn.DoClick()
						netstream.Start("cPlayerActive", entity)
					end

				local btnOff = actPanel:Add("DButton")
					btnOff:Dock(TOP)
					btnOff:SetText("Stop")
					btnOff:DockMargin(5, 5, 5, 0)
					function btnOff.DoClick()
						netstream.Start("cPlayerDisable", entity)
					end

				nut.gui["inv"..index] = cInv
	end)
	--[[
	netstream.Hook("cOpen", function(entity, index)
		local inventory = nut.item.inventories[index]
		local inventory2 = LocalPlayer():getChar():getInv()

		local playerInv = inventory2:show()
		playerInv:SetTitle("Player Inventory")
		playerInv:ShowCloseButton(false)
		
		local cInv = inventory:show()
		cInv:ShowCloseButton(true)
		cInv:SetTitle("")
		cInv:MoveLeftOf(playerInv, 4)
		cInv.OnClose = function(this)
			if (IsValid(playerInv) and !IsValid(nut.gui.menu)) then
				playerInv:Remove()
			end
			
			netstream.Start("invExit")
		end

		local actPanel = vgui.Create("DPanel")
		actPanel:SetDrawOnTop(true)
		actPanel:SetSize(100, cInv:GetTall())
		actPanel.Think = function(this)
			if (!cInv or !cInv:IsValid() or !cInv:IsVisible()) then
				this:Remove()
				return
			end

			local x, y = cInv:GetPos()
			this:SetPos(x - this:GetWide() - 5, y)
		end

		local btnOn = actPanel:Add("DButton")
			btnOn:Dock(TOP)
			btnOn:SetText("Play")
			btnOn:DockMargin(5, 5, 5, 0)
			function btnOn.DoClick()
				netstream.Start("cPlayerActive", entity)
			end

		local btnOff = actPanel:Add("DButton")
			btnOff:Dock(TOP)
			btnOff:SetText("Stop")
			btnOff:DockMargin(5, 5, 5, 0)
			function btnOff.DoClick()
				netstream.Start("cPlayerDisable", entity)
			end

		nut.gui["inv"..index] = cInv
	end)
	--]]
else
	function PLUGIN:LoadData()
		local savedTable = self:getData() or {}

		for k, v in ipairs(savedTable) do
			local cPlayer = ents.Create(v.class)
			cPlayer:SetPos(v.pos)
			cPlayer:SetAngles(v.ang)
			cPlayer:Spawn()
			cPlayer:Activate()
		end
	end

	function PLUGIN:SaveData()
		local savedTable = {}

		for k, v in ipairs(ents.GetAll()) do
			if (v:isPlayer()) then
				table.insert(savedTable, {class = v:GetClass(), pos = v:GetPos(), ang = v:GetAngles()})
			end
		end

		self:setData(savedTable)
	end
end