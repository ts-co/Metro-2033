-- Phoenix Project © 2016
SWEP.VElements = {
	["padonak"] = { type = "Model", model = "models/arxweapon/podonok.mdl", bone = "Ak.Body.Dummy", rel = "", pos = Vector(1, 1.5, 0.2), angle = Angle(180, -180, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[4] = 4, [5] = 1, [6] = 1, [7] = 1} },
	["mag"] = { type = "Model", model = "models/arxweapon/big_magazine.mdl", bone = "Ak.Mag.Bone", rel = "", pos = Vector(1.557, -0.101, 0.3), angle = Angle(1.169, -90, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["padonak"] = { type = "Model", model = "models/arxweapon/podonok.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.675, 1, -1.558), angle = Angle(-12.858, 1.169, 180), size = Vector(1.1, 1.1, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[4] = 2, [5] = 1, [6] = 1, [7] = 1} }
}

-- Variables that are used on both client and server
SWEP.Gun = ("m9k_mrp_padonak_mod") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "Metro 2033 RP"
SWEP.Author				= "Darsenvall"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= "Pull the trigger once to fire."
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Modified Lolife"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 1				-- Slot in the weapon selection menu
SWEP.SlotPos				= 57			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight				= 3			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 65
SWEP.ViewModelFlip			= true
SWEP.ViewModel = "models/weapons/v_ak74su.mdl"				-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_pistol.mdl"	-- Weapon world model
SWEP.ShowWorldModel = false
SWEP.Base				= "bobs_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.Primary.Sound			= Sound("podonok/single.wav")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 450			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 20	-- Size of a clip
SWEP.Primary.DefaultClip		= 0		-- Bullets you start with
SWEP.Primary.KickUp				= 1		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 1		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "357"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 65		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		--how many bullets to shoot, use with shotguns
SWEP.Primary.Damage		= 16	--base damage, scaled by game
SWEP.Primary.Spread		= .055	--define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .025 -- has to be the same as primary.spread

-- Enter iron sight info and bone mod info below
SWEP.SightsPos = Vector(2.35, -2.3, 1.49)
SWEP.SightsAng = Vector(0.349, 0, 0)
SWEP.RunSightsPos = Vector(2.124, -9.365, -3.987)
SWEP.RunSightsAng = Vector(48.262, -8.214, 0)
SWEP.ViewModelBoneMods = {
	["Ak.Mag.Bone"] = { scale = Vector(0.1, 0.1, 0.1), pos = Vector(-0, 0.1, 0), angle = Angle(0, 0, 0) },
	["Ak.Bolt.Bone"] = { scale = Vector(0.018, 0.018, 0.018), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Ak.Body.Dummy"] = { scale = Vector(0.203, 0.203, 0.203), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}