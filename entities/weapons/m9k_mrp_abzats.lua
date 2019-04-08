-- Phoenix Project © 2016
SWEP.VElements = {
	["abzats"] = { type = "Model", model = "models/arxweapon/abzats.mdl", bone = "Bone01", rel = "", pos = Vector(5.714, 25.454, -2.597), angle = Angle(-19.871, -75.974, 87.662), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["abzats"] = { type = "Model", model = "models/arxweapon/abzats.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(14.026, 1.299, -4.676), angle = Angle(-174.157, -164.805, 5), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Gun = ("m9k_mrp_abzats") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "Metro 2033 RP"
SWEP.Author				= "Darsenvall"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= "Click the trigger to fire, use the Right click to aim the sights."
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Abzats"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 89			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "shotgun"	-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel = "models/weapons/v_minigunvulcan.mdl"				-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_shot_xm1014.mdl"	-- Weapon world model
SWEP.Base 				= "bobs_gun_base"
SWEP.ShowWorldModel			= false
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("others/ubo_4.mp3")		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 280		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 20			-- Size of a clip
SWEP.Primary.DefaultClip		= 0	-- Default number of bullets in a clip
SWEP.Primary.KickUp				= 6				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 3		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 3	-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "buckshot"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 60		-- How much you 'zoom' in. Less is more! 

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.ShellTime			= .35

SWEP.Primary.NumShots	= 16		//how many bullets to shoot, use with shotguns
SWEP.Primary.Damage		= 6	//base damage, scaled by game
SWEP.Primary.Spread		= .15	//define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .135 // has to be the same as primary.spread
-- Because irons don't magically give you less pellet spread!

-- Enter iron sight info and bone mod info below
SWEP.SightsPos = Vector(-6.441, 0, 0.6)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(-4.56, 0, -3.56)
SWEP.RunSightsAng = Vector(0, 31.658, -9.849)
SWEP.ViewModelBoneMods = {
	["Bone01"] = { scale = Vector(0.075, 0.075, 0.075), pos = Vector(-12.778, -8.705, -0.556), angle = Angle(0, 0, 0) },
	["main_body-"] = { scale = Vector(0.148, 0.148, 0.148), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}