-- Phoenix Project © 2016
SWEP.VElements = {
	["element_name"] = { type = "Model", model = "models/arxweapon/autoshotgun.mdl", bone = "v_weapon.xm1014_Parent", rel = "", pos = Vector(-0.35, 2.895, -3.833), angle = Angle(87.706, -3.359, 88.831), size = Vector(0.842, 0.842, 0.842), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} }
}

SWEP.WElements = {
	["element_name"] = { type = "Model", model = "models/arxweapon/autoshotgun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, 0), angle = Angle(-13.974, -4.466, 180), size = Vector(0.944, 0.944, 0.944), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} }
}

SWEP.Gun = ("m9k_mrp_autoshotgun") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "Metro 2033 RP"
SWEP.Author				= "Darsenvall"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= "Click the trigger to fire, use the Right click to aim the sights."
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Shambler"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 89			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "ar2"	-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_shot_xm1014.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_shot_xm1014.mdl"	-- Weapon world model
SWEP.Base 				= "bobs_shotty_base"
SWEP.ShowWorldModel			= false
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("others/ubo_1.mp3")		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 150		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 6			-- Size of a clip
SWEP.Primary.DefaultClip		= 0	-- Default number of bullets in a clip
SWEP.Primary.KickUp				= 6				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.25		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 1.6	-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "buckshot"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 60		-- How much you 'zoom' in. Less is more! 

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.ShellTime			= .35

SWEP.Primary.NumShots	= 12		//how many bullets to shoot, use with shotguns
SWEP.Primary.Damage		= 6.5	//base damage, scaled by game
SWEP.Primary.Spread		= .08	//define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .08 // has to be the same as primary.spread
-- Because irons don't magically give you less pellet spread!

-- Enter iron sight info and bone mod info below
SWEP.SightsPos = Vector(4.3, -2.5, 0.1)
SWEP.SightsAng = Vector(-1.5, -2.7, -5)
SWEP.RunSightsPos = Vector(-1.841, 1.386, -1)
SWEP.RunSightsAng = Vector(-8.441, -40.614, 0)
SWEP.ViewModelBoneMods = {
	["v_weapon.xm1014_Parent"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}