-- Phoenix Project © 2016
SWEP.VElements = {
	["rpk"] = { type = "Model", model = "models/arxweapon/w_rpk.mdl", bone = "selector", rel = "", pos = Vector(3.635, 1.557, 0.5), angle = Angle(0, 180, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
	["clip"] = { type = "Model", model = "models/arxweapon/w_rpk_clip.mdl", bone = "20mag07", rel = "", pos = Vector(-0.45, -0.5, 6), angle = Angle(-90, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} }
}

SWEP.WElements = {
	["rpk"] = { type = "Model", model = "models/arxweapon/w_rpk.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 0.518, -0.401), angle = Angle(-171.818, 180, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


SWEP.Gun = ("m9k_mrp_rpk") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "Metro 2033 RP"
SWEP.Author				= "Darsenvall"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= "Left click to fire, right click to use the Sights."
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "RPK"		-- Weapon name (Shown on HUD)	
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
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_fnfalnato.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_pistol.mdl"		-- Weapon world model
SWEP.ShowWorldModel			= false
SWEP.Base				= "bobs_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.Primary.Sound			= Sound("others/ak74_shoot_3.mp3")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 550			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 45		-- Size of a clip
SWEP.Primary.DefaultClip		= 0		-- Bullets you start with
SWEP.Primary.KickUp				= 0.8		-- Maximum up recoil (rise) /default = 0.3
SWEP.Primary.KickDown			= 0.55		-- Maximum down recoil (skeet) /default = 0.3
SWEP.Primary.KickHorizontal		= 0.77		-- Maximum up recoil (stock) /default = 0.3
SWEP.Primary.Automatic			= true		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "ar2"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 65		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 25	-- Base damage per bullet
SWEP.Primary.Spread		= .065	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .033 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.SightsPos = Vector(-2.935, -11.671, 0.97)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.IronSightsPos = Vector(-2.935, -11.671, 0.97)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(2.68, 0, 1.36)
SWEP.RunSightsAng = Vector(-10.554, 37.99, 0)
SWEP.ViewModelBoneMods = {
	["selector"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, -0.301, 0), angle = Angle(0, 0, 0) }
}