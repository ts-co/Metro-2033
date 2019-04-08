-- Variables that are used on both client and server
SWEP.Gun = ("stalker_deagle") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "S.T.A.L.K.E.R"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Desert Eagle"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 1				-- Slot in the weapon selection menu
SWEP.SlotPos				= 3			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "pistol"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.SelectiveFire		= false

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_pist_stalker_deagle.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_stalker_deagle.mdl"	-- Weapon world model
SWEP.ShowWorldModel = true
SWEP.Base				= "z_stalker_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

///ADDED VARIABLES by Zombie Extinguisher///
SWEP.ClipDrop_Enable = false // Should clipdrop be enabled ?
SWEP.ClipDrop_Clip_Model = "models/stalker_mags/deagle_mag.mdl" // if so, what model should the clip be ?
SWEP.ClipDrop_Sound = "" // should the weapon make a special sound when the clip is created ?
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

SWEP.Primary.Sound			= Sound("deagle_shoot.single")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 145			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 8	-- Size of a clip
SWEP.Primary.DefaultClip		= 16		-- Bullets you start with
SWEP.Primary.KickUp				= 3		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.5		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.5		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "z_stalker_deagle"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 55		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 30	-- Base damage per bullet
SWEP.Primary.Spread		= .025	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .015 -- Ironsight accuracy, should be the same for shotguns


-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.SightsPos = Vector(4.289, 0, 0.959)
SWEP.SightsAng = Vector(1.378, 0, 0)
SWEP.RunSightsPos = Vector (-2, -1, 1)
SWEP.RunSightsAng = Vector (-10, -30, -10)


////I FOUND THE MODELS HERE: http://css.gamebanana.com/skins/33053 ////
