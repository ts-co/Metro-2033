AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Meat Pile"
ENT.Category = "NutScript"
ENT.Spawnable = true
ENT.AdminOnly = true

local food = {"humanflesh", "rat", "pork", "creaturemeat", "meatfat"}
local randomFood = food[math.random(1, 4)]
local randomAmount = math.random(1, 5)
local chances = 3

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/devcon/mrp/props/raw_meat.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetHealth(math.random(100,300))
		self:setNetVar("name", "Unknown Meat")
		chances = 3

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		else
			local min, max = Vector(-8, -8, -8), Vector(8, 8, 8)

			self:PhysicsInitBox(min, max)
			self:SetCollisionBounds(min, max)
		end
	end

	function ENT:OnTakeDamage(damage)
		local client = damage:GetInflictor()

		if damage:GetDamageType() == 8194 then --Slashing
			local destroyChance = math.random(-3, 3) + client:getChar():getAttrib("str", 0)

			if destroyChance >= 1 then
				self:SetHealth(self:Health() - damage:GetDamage())
			end

			self:EmitSound("npc/fast_zombie/claw_strike"..math.random(1, 3)..".wav")

			local blood = ents.Create("env_blood")
				blood:SetKeyValue("targetname", "carlbloodfx")
				blood:SetKeyValue("parentname", "prop_ragdoll")
				blood:SetKeyValue("spawnflags", 8)
				blood:SetKeyValue("spraydir", math.random(500) .. " " .. math.random(500) .. " " .. math.random(500))
				blood:SetKeyValue("amount", 250.0)
				blood:SetCollisionGroup( COLLISION_GROUP_WORLD )
				blood:SetPos(self:GetPos())
				blood:Spawn()
				blood:Fire("EmitBlood")
		end

		if self:Health() <= 0 then
			local inventory = client:getChar():getInv()

			inventory:add(randomFood, randomAmount)
			client:notifyLocalized("You have recieved "..randomAmount.." "..randomFood.." pieces.")

			self:EmitSound("npc/antlion_grub/squashed.wav")
			self:Remove()
		end
	end

	function ENT:Use(client)
		local identifyingChance = math.random(-3, 3)
		if identifyingChance >= 2 && chances > 0 then
			nut.chat.send(client, "it", "After feeling around, it seems that the strange meat is made up of "..randomFood..".")
			self:setNetVar("name", randomFood)
			chances = 0
		elseif identifyingChance <= 2 && chances > 0 then
			nut.chat.send(client, "it", "The contents of the meat are still unknown.")
			chances = chances - 1
		elseif chances == 0 then
			client:notifyLocalized("All attempts have been exahusted in identifying this meat.")
		end
	end
else
	ENT.DrawEntityInfo = true

	local toScreen = FindMetaTable("Vector").ToScreen
	local colorAlpha = ColorAlpha
	local drawText = nut.util.drawText
	local configGet = nut.config.get

	function ENT:onDrawEntityInfo(alpha)
		local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)))
		local x, y = position.x, position.y
		drawText(string.gsub(self:getNetVar("name"), "^.", string.upper).." Pile", x, y, colorAlpha(configGet("color"), alpha), 1, 1, nil, alpha * 0.65)
		drawText("Until Broken: "..self:Health().."%", x, y + 16, colorAlpha(Color(135, 211, 124), alpha), 1, 1, nil, alpha * 0.65)
	end
end