-- Phoenix Project © 2016
SWEP.VElements = {
	["bastard"] = { type = "Model", model = "models/arxweapon/bastardgun.mdl", bone = "sten", rel = "", pos = Vector(5.5, -3.901, -1.558), angle = Angle(180, 0, 90), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 2} },
	["magazine"] = { type = "Model", model = "models/arxweapon/bastardgunclip.mdl", bone = "mag", rel = "", pos = Vector(1.557, -4.5, -9.87), angle = Angle(90, 0, 90), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} }
}

SWEP.WElements = {
	["element_name"] = { type = "Model", model = "models/arxweapon/bastardgun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.845, 1.983, -0.673), angle = Angle(-4.232, 0, 180), size = Vector(0.852, 0.852, 0.852), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} }
}


SWEP.Gun = ("m9k_mrp_bastard_silenced") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "Metro 2033 RP"
SWEP.Author				= "Darsenvall"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= "Left click to fire, right click to use the Sights."
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Silenced Bastard Gun"		-- Weapon name (Shown on HUD)	
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
SWEP.ViewModel				= "models/weapons/v_smgsten.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_pistol.mdl"		-- Weapon world model
SWEP.ShowWorldModel			= false
SWEP.Base				= "bobs_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.Primary.Sound			= Sound("bastard/silencer shoot-1.wav")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 400			-- This is in Rounds Per Minute /default = 500
SWEP.Primary.ClipSize			= 25		-- Size of a clip /default = 25
SWEP.Primary.DefaultClip		= 0		-- Bullets you start with
SWEP.Primary.KickUp				= 1.25		-- Maximum up recoil (rise) /default = 0.3
SWEP.Primary.KickDown			= 0.035		-- Maximum down recoil (skeet) /default = 0.3
SWEP.Primary.KickHorizontal		= 0.65		-- Maximum up recoil (stock) /default = 0.3
SWEP.Primary.Automatic			= true		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "ar2"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 65		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 15	-- Base damage per bullet /default = 30
SWEP.Primary.Spread		= .075	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact) /default = .023
SWEP.Primary.IronAccuracy = .03 -- Ironsight accuracy, should be the same for shotguns /default = .013

-- Enter iron sight info and bone mod info below
SWEP.SightsPos = Vector(4.329, -4.801, 2.7)
SWEP.SightsAng = Vector(-0.461, 0.4, 0)
SWEP.RunSightsPos = Vector(-1.841, -3.386, 0.708)
SWEP.RunSightsAng = Vector(-7.441, -41.614, 0)
SWEP.ViewModelBoneMods = {
	["bolt puller"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["sten"] = { scale = Vector(0.1, 0.1, 0.1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["mag"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}