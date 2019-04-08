AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Mushroom Farm"
ENT.Author = "Pilot"
ENT.Spawnable = false
ENT.AdminOnly = true
ENT.RenderGroup 		= RENDERGROUP_BOTH
ENT.Category = "NutScript"
ENT.invType = "mushroomfarm"

Inventory = FindMetaTable("GridInv")
nut.item.inventories = nut.inventory.instances

if (SERVER) then

	local function CanOnlyTransferSeeds(inventory, action, context)
		if (action ~= "transfer") then return end

		local item, toInventory = context.item, context.to
		if item.name != "Mushroom Seeds" then
			return false, "You can only place seeds here."
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
		self:SetModel("models/props/mushtable1.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:setNetVar("active", false)
		self:SetUseType(SIMPLE_USE)
		self.receivers = {}
		local physicsObject = self:GetPhysicsObject()

		if (IsValid(physicsObject)) then
			physicsObject:Wake()
		end

		Inventory:instance({w = 8, h = 1})
			:next(function(inventory)
				self:setInventory(inventory)
				inventory:addAccessRule(CanOnlyTransferSeeds)
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
	
	function ENT:activate(seconds)
		if (self:getNetVar("gone")) then
			return
		end

		local timerName = self:GetClass():lower() .. "_" .. self:EntIndex() .. "_stoveThink"
		if (seconds != 0 and !self:getNetVar("active")) then
			seconds = math.abs(seconds)

			timer.Create(timerName, seconds, 1, function()
				if (self and self:IsValid()) then
					self:activate(0)
				end
			end)
		else
			timer.Destroy(timerName)
		end

		self:setNetVar("active", !self:getNetVar("active"))
		self:EmitSound("buttons/lightswitch2.wav")
	end
	
	function ENT:Use(activator)
		if (self:getNetVar("gone")) then
			return
		end

		local inventory = self:getInv()

		if (inventory and (activator.nutNextOpen or 0) < CurTime()) then
			if (activator:getChar()) then
				activator:setAction("Opening...", 1, function()
					if (activator:GetPos():Distance(self:GetPos()) <= 100) then
						self.receivers[activator] = true
						activator.nutBagEntity = self
						
						inventory:sync(activator)
						netstream.Start(activator, "stvOpen", self, inventory:getID())
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

	local heatCooks = {
		{0, 3, 1},
		{3, 10, 3},
		{10, 25, 4},
	}
	function ENT:Think()
		if (self:getNetVar("gone")) then
			return
		end

		if (self:getNetVar("active")) then
			local items = self:getInv():getItems(true)

			for k, v in pairs(items) do
				v:setData("heat", v:getData("heat", 0) + 1)

				if (v.isFood and v.cookable) then
					local heat = v:getData("heat")
					local cookLevel = v:getData("cooked", 0)
					local overheat = true

					for _, range in ipairs(heatCooks) do
						if (heat >= range[1] and heat < range[2]) then
							if (cookLevel != range[3]) then
								v:setData("cooked", range[3])
							end
							overheat = false

							break
						end
					end

					if (overheat) then
						if (cookLevel != 2) then
							v:setData("cooked", 2)
						end
					end
				end
			end

			self:NextThink(CurTime() + 1)
			return true
		end
	end

	netstream.Hook("stvActive", function(client, entity, seconds)
		local distance = client:GetPos():Distance(entity:GetPos())
		
		if (entity:IsValid() and client:IsValid() and client:getChar() and
			distance < 128) then
			entity:activate(seconds)
		end
	end)
else
	function ENT:Draw()
		self:DrawModel()
	end
end
