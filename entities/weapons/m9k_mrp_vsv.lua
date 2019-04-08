-- Phoenix Project © 2016
SWEP.VElements = {
	["clip"] = { type = "Model", model = "models/arxweapon/vsvclip.mdl", bone = "Ak.Mag.Bone", rel = "", pos = Vector(2.596, -7.45, -0.201), angle = Angle(1.169, -92.338, 92.337), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["vsv"] = { type = "Model", model = "models/arxweapon/vsv.mdl", bone = "Ak.Body.Dummy", rel = "", pos = Vector(-2.6, -0.5, 0), angle = Angle(0, 0, 92.337), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 2, [2] = 1, [3] = 1} }
}

SWEP.WElements = {
	["vsv"] = { type = "Model", model = "models/arxweapon/vsv.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0.518, 0.699), angle = Angle(-5.844, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[2] = 1, [3] = 1} }
}


SWEP.Gun = ("m9k_mrp_vsv") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "Metro 2033 RP"
SWEP.Author				= "Darsenvall"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= "Left click to fire, right click to use the Sights."
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "VSV"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 23			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.SelectiveFire		= true

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_ak74su.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_pistol.mdl"		-- Weapon world model
SWEP.ShowWorldModel			= false
SWEP.ShowViewModel = false
SWEP.Base				= "bobs_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.Primary.Sound			= Sound("vsv/shoot-1.wav")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 450			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 20		-- Size of a clip
SWEP.Primary.DefaultClip		= 0		-- Bullets you start with
SWEP.Primary.KickUp				= 0.4		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.015		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.3		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "ar2"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 65		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 22	-- Base damage per bullet
SWEP.Primary.Spread		= .055	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact) /default = .023
SWEP.Primary.IronAccuracy = .0175 -- Ironsight accuracy, should be the same for shotguns /default = .013

-- Enter iron sight info and bone mod info below
SWEP.SightsPos = Vector(2.7, -4.624, 1.759)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.IronSightsPos = Vector(2.7, -4.624, 1.759)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(-1.841, -3.386, 0.708)
SWEP.RunSightsAng = Vector(-7.441, -41.614, 0)
SWEP.ViewModelBoneMods = {
	["Ak.Mag.Bone"] = { scale = Vector(0.4, 0.4, 0.4), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Ak.Bolt.Bone"] = { scale = Vector(0.2, 0.2, 0.2), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Ak.Body.Dummy"] = { scale = Vector(0.1, 0.1, 0.1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}