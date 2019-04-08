PLUGIN.name = "Camera"
PLUGIN.author = "Pilot"
PLUGIN.desc = "Take pictures like in the olden days."

local entityMeta = FindMetaTable("Entity")

function entityMeta:isPlayer()
	local class = self:GetClass()

	return (class == "nut_camera")
end

if (CLIENT) then
	netstream.Hook("camOpen", function(entity, index)
		local inventory = nut.item.inventories[index]

		if (IsValid(entity) and inventory and inventory.slots) then
			nut.gui.inv1 = vgui.Create("nutInventory")
			nut.gui.inv1:ShowCloseButton(true)

			local inventory2 = LocalPlayer():getChar():getInv()

			if (inventory2) then
				nut.gui.inv1:setInventory(inventory2)
			end

			local panel = vgui.Create("nutInventory")
			panel:ShowCloseButton(true)
			panel:SetTitle("Player")
			panel:setInventory(inventory)
			panel:MoveLeftOf(nut.gui.inv1, 4)
			panel.OnClose = function(this)
				if (IsValid(nut.gui.inv1) and !IsValid(nut.gui.menu)) then
					nut.gui.inv1:Remove()
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

		local viewBtn = actPanel:Add("DButton")
			viewBtn:Dock(TOP)
			viewBtn:SetText("Viewfinder")
			viewBtn:DockMargin(5, 5, 5, 0)
			function viewBtn.DoClick()
				local x, y = (ScrW() / 2) - 170, (ScrH() / 2) - 250
				local w, h = 499, 482

				local camFrame = panel:Add("DFrame")
				camFrame:SetSize(w, h)
				camFrame:SetPos(x, y)
				camFrame:ShowCloseButton(true)
				camFrame:SetTitle("")
				camFrame:MakePopup()
				function camFrame:Paint( w, h )
					local x, y = self:GetPos()
					Derma_DrawBackgroundBlur(camFrame, 5)

					local camData = {}
					camData.angles = entity:EyeAngles()
					camData.origin = entity:GetPos()
					camData.x = x
					camData.y = y
					camData.w = w
					camData.h = h
					camData.drawviewmodel = false
					render.RenderView(camData)
				end

				local captureBtn = camFrame:Add("DButton")
				captureBtn:Dock(BOTTOM)
				captureBtn:SetText("Take Photograph")
				function captureBtn.DoClick()
					netstream.Start("camCapture", entity)
				end
			end

			nut.gui["inv"..index] = panel
		end
	end)
else
	function PLUGIN:LoadData()
		local savedTable = self:getData() or {}

		for k, v in ipairs(savedTable) do
			local camera = ents.Create(v.class)
			camera:SetPos(v.pos)
			camera:SetAngles(v.ang)
			camera:Spawn()
			camera:Activate()
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