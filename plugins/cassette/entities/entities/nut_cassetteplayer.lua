ENT.Type = "anim"
ENT.PrintName = "Cassette Player"
ENT.Category = "NutScript"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.invType = "cassetteplayer"

Inventory = FindMetaTable("GridInv")
nut.item.inventories = nut.inventory.instances

if (SERVER) then

local function CanOnlyTransferCassette(inventory, action, context)
	if (action ~= "transfer") then return end

	local item, toInventory = context.item, context.to
	if item.music == nil then
		return false, "You can only place cassette's here."
	else
		return true
	end
end

local function CanReplicateItemsForEveryone(inventory, action, context)
	if (action == "repl") then
		return true
	end
end

	function ENT:Initialize()
		self:SetModel("models/z-o-m-b-i-e/metro_2033/mafony/m33_mafon_02.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self.receivers = {}
		self:setNetVar("songOn", false)
		local physObject = self:GetPhysicsObject()

		if (IsValid(physObject)) then
			physObject:Wake()
		end

		Inventory:instance({w = 1, h = 1})
			:next(function(inventory)
				self:setInventory(inventory)
				inventory:addAccessRule(CanOnlyTransferCassette)
				inventory:addAccessRule(CanReplicateItemsForEveryone)
				inventory.noBags = false
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
		local itemKey = inventory:getItems()
		for k, v in pairs(itemKey) do
			if v.music != nil and self:getNetVar("songOn") == false then
				self:setNetVar("songOn", true)

				sound.Add({
					name = "cplayer_song",
					channel = CHAN_STATIC,
					volume = 1.0,
					level = 80,
					pitch = {95, 110},
					sound = v.music
				})
				
				self:EmitSound("cplayer_song", 75, 1, 100)
			end
		end
	end

	function ENT:disable()
		if self:getNetVar("songOn") == true then
			self:StopSound("cplayer_song")
			self:setNetVar("songOn", false)
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
						net.Start("cOpen")
						net.WriteType(self)
						net.WriteUInt(inventory:getID(), 32)
						net.Send(activator)
						--netstream.Start(activator, "cOpen", self, inventory:getID())
					end
				end)
			end

			activator.nutNextOpen = CurTime() + 1.5
		end
	end

	function ENT:OnRemove()		
		local index = self:getNetVar("id")

		if (!nut.shuttingDown and !self.nutIsSafe and index) then
			--local item = nut.item.inventories[index]
			local item = nut.inventory.instances[index]

			if (item) then
				--nut.item.inventories[index] = nil
				nut.inventory.instances[index] = nil

				nut.db.query("DELETE FROM nut_items WHERE _invID = "..index)
				nut.db.query("DELETE FROM nut_inventories WHERE _invID = "..index)

				hook.Run("StorageItemRemoved", self, item)
			end
		end

		if self:getNetVar("songOn") == true then
			self:StopSound("cplayer_song")
			self:setNetVar("songOn", false)
		end
	end

	function table.empty (self)
		for _, _ in pairs(self) do
			return false
		end
		return true
	end

	function ENT:Think()
		local inventory = self:getInv()
		if (not inventory) then return end
		local item = inventory:getItems()

		if table.empty(item) == true then
			self:StopSound("cplayer_song")
			self:setNetVar("songOn", false)
		end
	end

	function ENT:getInv()
		return nut.item.inventories[self:getNetVar("id", 0)]
	end

	netstream.Hook("cPlayerActive", function(client, entity)
		local distance = client:GetPos():Distance(entity:GetPos())

		if (entity:IsValid() and client:IsValid() and client:getChar() and distance < 128) then
			entity:activate()
		end
	end)

	netstream.Hook("cPlayerDisable", function(client, entity)
		local distance = client:GetPos():Distance(entity:GetPos())

		if (entity:IsValid() and client:IsValid() and client:getChar() and distance < 128) then
			entity:disable()
		end
	end)
else
	ENT.DrawEntityInfo = true

	local playingColor = Color(242, 38, 19)
	local COLOR_PLAYING = Color(135, 211, 124)
	local COLOR_STOPPED = Color(242, 38, 19)
	local toScreen = FindMetaTable("Vector").ToScreen
	local colorAlpha = ColorAlpha
	local drawText = nut.util.drawText
	local configGet = nut.config.get

	function ENT:onDrawEntityInfo(alpha)
		local status = self:getNetVar("songOn")
		local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)))
		local x, y = position.x, position.y

		--Translation doohikey
		local playing = "Playing"
		if status == true then
			playing = "Playing"
			playingColor = COLOR_PLAYING
		else
			playing = "Not Playing"
			playingColor = COLOR_STOPPED
		end

		y = y - 20
		--local tx, ty = nut.util.drawText(locked and "P" or "Q", x, y, colorAlpha(locked and COLOR_LOCKED or COLOR_UNLOCKED, alpha), 1, 1, "nutIconsMedium", alpha * 0.65)
		local tx, ty = drawText(playing, x, y, colorAlpha(playing and playingColor, alpha), 1, 1, nil, alpha * 0.65)
		y = y + ty*.9
		local tx, ty = drawText("Cassette Player", x, y, colorAlpha(configGet("color"), alpha), 1, 1, nil, alpha * 0.65)
	end
end