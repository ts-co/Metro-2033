
SWEP.Contact 		= ""
SWEP.Author			= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.ViewModelFOV 		= 65
SWEP.ViewModel			= "models/weapons/v_basball.mdl"
SWEP.WorldModel			= "models/weapons/w_basball.mdl"
SWEP.HoldType 			= "melee"


SWEP.FiresUnderwater = true
SWEP.base					= "weapon_base"
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
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
SWEP.PrintName			= "Metal Bat"			
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
	self.Weapon:SetSkin( 2 )

end
	
function SWEP:PrimaryAttack()

	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 60 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )
	
		if ( trace.Hit ) then
			self.Weapon:EmitSound(Sound("weapons/melee/bat/aluminum_hit-0"..math.random(1,4)..".wav"))
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

end

if CLIENT then

	killicon.Add( "weapon_bat_aluminum", "HUD/killicons/weapon_bat_aluminum", Color ( 255, 255, 0, 255 ) )

end