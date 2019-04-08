-- Phoenix Project © 2016
SWEP.VElements = {
	["mag"] = { type = "Model", model = "models/arxweapon/ventil_magazin.mdl", bone = "a_mag", rel = "", pos = Vector(-2.597, 2, 4), angle = Angle(0, 0, -94.676), size = Vector(1.1, 1.404, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["ventil"] = { type = "Model", model = "models/arxweapon/ventil_pustishka.mdl", bone = "a_fg42", rel = "", pos = Vector(-4.676, 1.7, 0.518), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} }
}

SWEP.WElements = {
	["ventil"] = { type = "Model", model = "models/arxweapon/ventil_pustishka.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.599, 0.518, -1.8), angle = Angle(-174.157, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Gun = ("m9k_mrp_ventil") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "Metro 2033 RP"
SWEP.Author				= "Darsenvall"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.PrintName				= "Valve"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 28			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- Set false if you want no crosshair from hip
SWEP.Weight				= 30			-- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.XHair					= true		-- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.BoltAction				= false		-- Is this a bolt action rifle?
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 62
SWEP.ViewModelFlip			= true
SWEP.ViewModel = "models/weapons/v_rif_fg42.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ShowWorldModel			= false
SWEP.Base 				= "bobs_scoped_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("ventil/ventil_base_shot.mp3")		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 15		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 8		-- Size of a clip
SWEP.Primary.DefaultClip		= 0	-- Bullets you start with
SWEP.Primary.KickUp				= 1				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= .6			-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= .5		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "SniperPenetratedRound"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.ScopeZoom			= 3	
SWEP.Secondary.UseACOG			= false -- Choose one scope type
SWEP.Secondary.UseMilDot		= false	-- I mean it, only one	
SWEP.Secondary.UseSVD			= true	-- If you choose more than one, your scope will not show up at all
SWEP.Secondary.UseParabolic		= false	
SWEP.Secondary.UseElcan			= false
SWEP.Secondary.UseGreenDuplex	= false	
SWEP.Secondary.UseAimpoint		= false
SWEP.Secondary.UseMatador		= false

SWEP.data 				= {}
SWEP.data.ironsights		= 1
SWEP.ScopeScale 			= 0.7
SWEP.ReticleScale 			= 0.6

SWEP.Primary.NumShots	= 1	--how many bullets to shoot, use with shotguns
SWEP.Primary.Damage		= 45	--base damage, scaled by game
SWEP.Primary.Spread		= .09	--define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .0012 -- has to be the same as primary.spread

-- enter iron sight info and bone mod info below

SWEP.IronSightsPos = Vector (2.275, -2.9708, 0.5303)
SWEP.IronSightsAng = Vector (0, 0, 0)
SWEP.SightsPos = Vector (2.275, -2.9708, 0.5303)
SWEP.SightsAng = Vector (0, 0, 0)
SWEP.RunSightsPos = Vector(-3.04, 0, 0.36)
SWEP.RunSightsAng = Vector(-4.926, -35.176, 0)
SWEP.ViewModelBoneMods = {
	["R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0.5), angle = Angle(0, 0, 0) },
	["a_trigger"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(-17.963, -23.519, -23.149), angle = Angle(0, 0, 0) },
	["a_fg42"] = { scale = Vector(0.148, 0.148, 0.148), pos = Vector(1, 0, 0.5), angle = Angle(0, 0, 0) },
	["a_bolt"] = { scale = Vector(0.203, 0.203, 0.203), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["a_mag"] = { scale = Vector(0.148, 0.148, 0.148), pos = Vector(0.925, 0, 0.5), angle = Angle(0, 0, 0) }
}