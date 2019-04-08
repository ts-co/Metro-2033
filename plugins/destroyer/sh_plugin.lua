PLUGIN.name = "Destroyer"
PLUGIN.author = "Pilot"
PLUGIN.desc = "Destroys anything you put inside it."

local entityMeta = FindMetaTable("Entity")

function entityMeta:isPlayer()
	local class = self:GetClass()

	return (class == "nut_destroyer")
end

if (CLIENT) then
	netstream.Hook("dOpen", function(entity, index)
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

		local btn = actPanel:Add("DButton")
			btn:Dock(TOP)
			btn:SetText("Destroy")
			btn:DockMargin(5, 5, 5, 0)
			function btn.DoClick()
				netstream.Start("dPlayerActive", entity)
			end

		nut.gui["inv"..index] = cInv
	end)
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