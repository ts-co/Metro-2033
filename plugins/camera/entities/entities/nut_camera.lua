ENT.Type = "anim"
ENT.PrintName = "Camera"
ENT.Category = "NutScript"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.invType = "camera"
nut.item.registerInv(ENT.invType, 1, 1)

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/pilot/voluntarygaming/vintagecamera.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self.receivers = {}
		self:setNetVar("camOpen", false)
		local physObject = self:GetPhysicsObject()

		if (IsValid(physObject)) then
			physObject:Wake()
		end

		nut.item.newInv(0, self.invType, function(inventory)
			self:setInventory(inventory)
			inventory.noBags = true

			function inventory:onCanTransfer(client, oldX, oldY, x, y, newInvID)
				return hook.Run("StorageCanTransfer", inventory, client, oldX, oldY, newInvID)
			end
		end)
	end

	function ENT:setInventory(inventory)
		if (inventory) then
			self:setNetVar("id", inventory:getID())

			inventory.onAuthorizeTransfer = function(inventory, client, oldInventory, item)
				if (IsValid(client) and IsValid(self) and self.receivers[client]) then
					return true
				end
			end

			inventory.getReceiver = function(inventory)
				local receivers = {}

				for k, v in pairs(self.receivers) do
					if (IsValid(k)) then
						receivers[#receivers + 1] = k
					end
				end

				return #receivers > 0 and receivers or nil
			end
		end
	end

	function ENT:activate()
		local inventory = self:getInv()
		local item = inventory:getItemAt(1, 1)
		
		if item.name == "Photograph" and self:getNetVar("camOpen") == false and item.used != true then
			netstream.Start(nil, "itemID", item.id)
			RunConsoleCommand("camera_screenshot")
			item.used = true
		end
	end
	
	function ENT:Use(activator)
		local inventory = self:getInv()

		if (inventory and (activator.nutNextOpen or 0) < CurTime()) then
			if (activator:getChar()) then
				activator:setAction("Opening...", 1, function()
					if (activator:GetPos():Distance(self:GetPos()) <= 100) then
						self.receivers[activator] = true
						activator.nutBagEntity = self
						
						inventory:sync(activator)
						netstream.Start(activator, "camOpen", self, inventory:getID())
					end
				end)
			end

			activator.nutNextOpen = CurTime() + 1.5
		end
	end

	function ENT:OnRemove()		
		local index = self:getNetVar("id")

		if (!nut.shuttingDown and !self.nutIsSafe and index) then
			local item = nut.item.inventories[index]

			if (item) then
				nut.item.inventories[index] = nil

				nut.db.query("DELETE FROM nut_items WHERE _invID = "..index)
				nut.db.query("DELETE FROM nut_inventories WHERE _invID = "..index)

				hook.Run("StorageItemRemoved", self, item)
			end
		end
	end

	function ENT:getInv()
		return nut.item.inventories[self:getNetVar("id", 0)]
	end

	netstream.Hook("camCapture", function(client, entity)
		local distance = client:GetPos():Distance(entity:GetPos())

		if (entity:IsValid() and client:IsValid() and client:getChar() and distance < 128) then
			entity:activate()
		end
	end)
else
	ENT.DrawEntityInfo = true

	local toScreen = FindMetaTable("Vector").ToScreen
	local colorAlpha = ColorAlpha
	local drawText = nut.util.drawText
	local configGet = nut.config.get

	function ENT:onDrawEntityInfo(alpha)
		local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)))
		local x, y = position.x, position.y
		local x, y = drawText("Camera", x, y, colorAlpha(configGet("color"), alpha), 1, 1, nil, alpha * 0.65)
	end

	local ScreenshotRequested = false
	function RequestAScreenshot()
		ScreenshotRequested = true
	end

	concommand.Add( "camera_screenshot", RequestAScreenshot )

	hook.Add("PostRender", "renderCapture", function()
		if ( !ScreenshotRequested ) then return end
		ScreenshotRequested = false

		local x, y = (ScrW() / 2) - 170, (ScrH() / 2) - 250
		local w, h = 499, 482

		local data = render.Capture({
			format = "jpeg",
			quality = 70,
			h = h - 35,
			w = w - 35,
			x = x,
			y = y,
		})
		netstream.Hook("itemID", function(this)
			itemID = this
		end)
		
		file.CreateDir("nutscript/metro/images")
		file.Write("nutscript/metro/images/image_"..itemID..".txt", util.Base64Encode(data))
	end)
end