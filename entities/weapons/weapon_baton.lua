SWEP.Contact 		= ""
SWEP.Author			= ""
SWEP.Instructions	= "Primary Fire: Swing Baton\nSecondary Fire: Knock on Door"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.ViewModelFOV 		= 47
SWEP.ViewModel			= "models/weapons/c_stunstick.mdl"
SWEP.WorldModel			= "models/weapons/w_stunbaton.mdl"
SWEP.HoldType 			= "melee"

SWEP.UseHands = true
SWEP.LowerAngles = Angle(15, -10, -20)

SWEP.FiresUnderwater = true
SWEP.base					= "weapon_base"
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= -1
SWEP.Primary.Delay 			= 0.65
SWEP.Primary.Damage 		= 24

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Category			= "Nutscript"
SWEP.PrintName			= "Baton"			
SWEP.Slot				= 0
SWEP.SlotPos			= 1
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
end

function SWEP:Deploy()

	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	self:SetWeaponHoldType(self.HoldType)

end
	
function SWEP:PrimaryAttack()

	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 60 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )
	
		if ( trace.Hit ) then
			self.Weapon:EmitSound("weapons/melee/bat/aluminum_hit-0"..math.random(1, 4)..".wav", 55)
			self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 8
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets( bullet )
			self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
			timer.Simple(0, function()
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			end)	
		else
			self.Weapon:EmitSound("Zombie.AttackMiss")
			self.Weapon:SendWeaponAnim( ACT_VM_MISSCENTER )
			self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
			timer.Simple(0, function()
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			end)	
		end
		
	timer.Create( "Idle", self:SequenceDuration(), 1, function() 
	if ( !IsValid( self ) ) then 
		return 
	end 
			self:SendWeaponAnim( ACT_VM_IDLE ) 
	end )

end

function SWEP:SecondaryAttack()
	self.Owner:LagCompensation(true)
		local data = {}
			data.start = self.Owner:GetShootPos()
			data.endpos = data.start + self.Owner:GetAimVector()*72
			data.filter = self.Owner
			data.mins = Vector(-8, -8, -30)
			data.maxs = Vector(8, 8, 10)
		local trace = util.TraceHull(data)
		local entity = trace.Entity
	self.Owner:LagCompensation(false)

	if (SERVER and IsValid(entity)) then
		local pushed

		if (entity:isDoor()) then
			if (hook.Run("PlayerCanKnock", self.Owner, entity) == false) then
				return
			end

			self.Owner:ViewPunch(Angle(-1.3, 1.8, 0))
			self.Owner:EmitSound("physics/plastic/plastic_box_impact_hard"..math.random(1, 4)..".wav")	
			self.Owner:SetAnimation(PLAYER_ATTACK1)

			self:SetNextSecondaryFire(CurTime() + 0.4)
			self:SetNextPrimaryFire(CurTime() + 1)
		elseif (entity:IsPlayer()) then
			local direction = self.Owner:GetAimVector() * (300 + (self.Owner:getChar():getAttrib("str", 0) * 3))
			direction.z = 0

			entity:SetVelocity(direction)

			pushed = true
		else
			local physObj = entity:GetPhysicsObject()

			if (IsValid(physObj)) then
				physObj:SetVelocity(self.Owner:GetAimVector() * 180)
			end

			pushed = true
		end

		if (pushed) then
			self:SetNextSecondaryFire(CurTime() + 1.5)
			self:SetNextPrimaryFire(CurTime() + 1.5)
			self.Owner:EmitSound("weapons/crossbow/hitbod"..math.random(1, 2)..".wav")

			local model = string.lower(self.Owner:GetModel())
			local owner = self.Owner

			if (nut.anim.getModelClass(model) == "metrocop") then
				self.Owner:forceSequence("pushplayer")
			end
		end
	end
end