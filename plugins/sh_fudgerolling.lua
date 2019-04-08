PLUGIN.name = "Fudge Rolling"
PLUGIN.author = "Pilot"
PLUGIN.desc = "Fixing Serious Roleplay the way no one else could."

--[[
TODO:
a derma panel to view that?
--]]

--[[
Point >= 100
Close = 200
Medium = 350
Far > 350
--]]

local distances = {}
	distances[1] = 100
	distances[2] = 200
	distances[3] = 350

local weaponsList = {
	--weaponclass, distancethreshold, basevalue, addedtrait, melee/range
	{"nut_hands", distances[1], 0, "str", "Melee"},
	{"m9k_mrp_aks74u", distances[3], 3, "", "Range"},
	{"m9k_mrp_ashot", distances[2], 4, "", "Range"},
	{"weapon_hl2axe", distances[1], 2, "str", "Melee"},
	{"weapon_bat_wood", distances[1], 1, "str", "Melee"},
	{"m9k_mrp_bastard", distances[3], 2, "", "Range"},
	{"m9k_mrp_bastard_silenced", distances[2], 3, "", "Range"},
	{"m9k_mrp_vihlop", 1000, 5, "", "Range"},
	{"weapon_crowbar", distances[1], 2, "str", "Melee"},
	{"m9k_mrp_doublet", distances[2], 3, "", "Range"},
	{"weapon_golf", distances[1], 1, "str", "Melee"},
	{"weapon_hammer", distances[1], 1, "str", "Melee"},
	{"m9k_mrp_hellsing", distances[3], 4, "", "Range"},
	{"m9k_mrp_kalash", distances[3], 3, "", "Range"},
	{"m9k_mrp_kalash_scoped", 1000, 3, "", "Range"},
	{"m9k_mrp_2012", distances[3], 4, "", "Range"},
	{"m9k_mrp_2012_silencer", distances[2], 5, "", "Range"},
	{"m9k_mrp_2012_scope_silencer", 1000, 4, "", "Range"},
	{"stalker_knife", distances[1], 3, "str", "Melee"},
	{"m9k_mrp_padonak", distances[2], 5, "", "Range"},
	{"m9k_mrp_padonak_mod", distances[2], 4, "", "Range"},
	{"m9k_mrp_padonak_silenced", distances[2], 5, "", "Range"},
	{"weapon_machete", distances[1], 4, "str", "Melee"},
	{"stalker_makarov", distances[2], 3, "", "Range"},
	{"weapon_hl2pickaxe", distances[1], 1, "str", "Melee"},
	{"weapon_hl2pipe", distances[1], 1, "", "Melee"},
	{"m9k_mrp_preved", distances[3], 7, "", "Range"},
	{"m9k_mrp_preved_scoped", 1000, 7, "", "Range"},
	{"m9k_mrp_revolver", distances[2], 5, "", "Range"},
	{"m9k_mrp_revolver_silenced", distances[1], 5, "", "Range"},
	{"m9k_mrp_rpk", distances[3], 4, "", "Range"},
	{"m9k_mrp_saiga", distances[2], 3, "", "Range"},
	{"m9k_mrp_autoshotgun", distances[2], 3, "", "Range"},
	{"weapon_hl2brokenbottle", distances[1], 0, "str", "Melee"},
	{"weapon_hl2shovel", distances[1], 1, "str", "Melee"},
	{"weapon_sledgehammer", distances[1], 3, "str", "Melee"},
	{"m9k_mrp_tihar", distances[3], 3, "", "Range"},
	{"m9k_mrp_tihar_scope", 1000, 3, "", "Range"},
	{"m9k_mrp_ventil", distances[3], 5, "", "Range"},
	{"m9k_mrp_vsv", distances[3], 4, "", "Range"},
	{"stalker_winchester", distances[2], 3, "", "Range"},
	{"stalker_deagle", distances[2], 5, "", "Range"}
}

local armorList = {
	{"models/devcon/mrp/act/stealth_light.mdl", 1},
	{"models/devcon/mrp/act/trenchcoat_black.mdl", 1},
	{"models/devcon/mrp/act/bandit_veteran.mdl", 1},
	{"models/devcon/mrp/act/green_coat.mdl", 1},
	{"models/devcon/mrp/act/stealth_light2.mdl", 2},
	{"models/devcon/mrp/act/bandit_light_2.mdl", 1},
	{"models/arx/neutral/hazmat_3.mdl", 2},
	{"models/arx/redline/red_line_soldier_18.mdl", 5},
	{"models/arx/redline/red_line_officer_4.mdl", 2},
	{"models/devcon/mrp/act/redline_soldier.mdl", 2},
	{"models/arx/redline/red_line_soldier_5.mdl", 2},
	{"models/arx/neutral/stalker.mdl", 2},
	{"models/arx/redline/red_line_soldier_10.mdl", 3},
	{"models/cultist_kun/reich_stalker1.mdl", 2},
	{"models/arx/reich/reich_soldier_3.mdl", 5},
	{"models/arx/reich/reich_officer_1.mdl", 2},
	{"models/devcon/mrp/act/reich_offizier_jake.mdl", 2},
	{"models/devcon/mrp/act/reich_officer.mdl", 2},
	{"models/arx/reich/reich_officer_2.mdl", 2},
	{"models/arx/reich/reich_soldier_16.mdl", 2},
	{"models/arx/reich/reich_soldier_17.mdl", 2},
	{"models/arx/reich/reich_soldier_16.mdl", 2},
	{"models/cultist_kun/nazi_sol.mdl", 2},
	{"models/cultist_kun/nazi_sniper.mdl", 2},
	{"models/arx/reich/reich_soldier_5.mdl", 2},
	{"models/arx/reich/reich_soldier_10.mdl", 3},
	{"models/devcon/mrp/act/bandit_vest2.mdl", 1},
	{"models/devcon/mrp/act/green_sweater.mdl", 1},
	{"models/devcon/mrp/act/white_jacket.mdl", 1},
	{"models/cultist_kun/red_stalker.mdl", 2},
	{"models/arx/hanza/hanza_soldier_1.mdl", 4},
	{"models/arx/hanza/hanza_soldier_2.mdl", 4},
	{"models/arx/hanza/hanza_soldier_3.mdl", 4},
	{"models/arx/hanza/hanza_soldier_1.mdl", 4}
}

local wordValue = {}
	wordValue[3] = "Superb"
	wordValue[2] = "Great"
	wordValue[1] = "Good"
	wordValue[0] = "Fair"
	wordValue[-1] = "Mediocre"
	wordValue[-2] = "Poor"
	wordValue[-3] = "Terrible"

local hurtValue = {}
	hurtValue[1] = "Scratch"
	hurtValue[2] = "Scratch"
	hurtValue[3] = "Hurt"
	hurtValue[4] = "Hurt"
	hurtValue[5] = "Hurt"
	hurtValue[6] = "Very Hurt"
	hurtValue[7] = "Very Hurt"
	hurtValue[8] = "Incapacitated"

local playerMeta = FindMetaTable("Player")

function playerMeta:getHunger()
	return (self:getNetVar("hunger")) or 0
end

function playerMeta:getHungerPercent()
	return math.Clamp(((CurTime() - self:getHunger()) / 23400), 0 ,1)
end

nut.command.add("combatroll", {
	syntax = "<string attackOrdodge>",
	onRun = function(client, arguments)
		local td = {}
			td.start = client:GetShootPos()
			--td.endpos = td.start + client:GetAimVector()*84
			td.endpos = td.start + client:EyeAngles():Forward()*10000
			td.filter = client
		local trace = util.TraceLine(td)
		local entity = trace.Entity

		local dice = {}
			dice[1] = math.random(-1, 1)
			dice[2] = math.random(-1, 1)
			dice[3] = math.random(-1, 1)

		--Weapon damage
		local weaponValue = 0

		--Concentric circles of damage
		local distanceModifier = 0

		--Armor damage
		local armorValue = 0

		--Stamina modifier
		local staminaValue = math.random(0, math.floor(client:getChar():getAttrib("stm", 0) / 5))

		if (IsValid(entity)) then --and entity:IsPlayer() and entity.character) then 
			local clientDistance = td.start:Distance(entity:GetPos())
			--[[
				Weapon Handling
			--]]
			for _, v in pairs(weaponsList) do		
				if v[1] == client:GetActiveWeapon():GetClass() && client:GetActiveWeapon():HasAmmo() then --What weapon is your character holding
					--Concentric circles of damage based on distance
					for k in pairs(distances) do
						if clientDistance > distances[k] then
							distanceModifier = distanceModifier - 1
						elseif clientDistance < distances[k] && distances[k] < v[2] then
							distanceModifier = distanceModifier + 1
						end
					end

					--Compile Weapon Damages
					if v[5] == "Melee" then
						if clientDistance <= distances[1] then
							weaponValue = v[3] + math.floor(client:getChar():getAttrib(v[4], 0) / 5)
						else
							client:notifyLocalized("You are too far to use a melee weapon.")
							return
						end
					elseif v[5] == "Range" then
						weaponValue = v[3] + distanceModifier + math.floor(client:getChar():getAttrib(v[4], 0) / 5)
					end
				elseif v[1] == client:GetActiveWeapon():GetClass() && client:GetActiveWeapon():HasAmmo() == false && clientDistance >= distances[1] then
					client:notifyLocalized("This weapon does not have ammunition loaded!")
					return false
				end
			end

			--[[
				Armor Handling
			--]]
			for _, v in pairs(armorList) do
				if v[1] == entity:GetModel() then
					armorValue = -(math.random(0, v[2]) + math.floor(entity:getChar():getAttrib("end", 0) / 5))
				end
			end

			--[[
				Hunger Handling
				
				75%-100% = 0 Penalty
				50%-75% = -1 Penalty
				25%-50% = -2 Penalty
				0%-25% = -3 Penalty
			--]]
			local foodPercent = 100 - (client:getHungerPercent() * 100)
			local foodValue = 0

			if foodPercent >= 75 then
				foodValue = 0
			elseif foodPercent >= 50 then
				foodValue = -1
			elseif foodPercent >= 25 then
				foodValue = -2
			elseif foodPercent >= 0 then
				foodValue = -3
			end

			--[[
				Dice Handling
			--]]
			local dicesumSimple = dice[1] + dice[2] + dice[3]
			local dicesumFinalAttack = dice[1] + dice[2] + dice[3] + weaponValue + armorValue + foodValue
			local dicesumFinalDodge = (dice[1] + dice[2] + dice[3] + staminaValue) + foodValue

			--Hurt messages
			local hurtMessage = "No Damage"
			for k2, v2 in pairs(hurtValue) do
				if (dicesumFinalAttack or dicesumFinalDodge) <= 0 then
					hurtMessage = "No Damage"
				elseif (dicesumFinalAttack or dicesumFinalDodge) == k2 then
					hurtMessage = v2
				elseif (dicesumFinalAttack or dicesumFinalDodge) >= 9 then
					hurtMessage = "Near Death"
				end
			end

			if (arguments[1] == "attack") then
				nut.chat.send(client, "roll", "...\n\nDice: "..dice[1]..", "..dice[2]..", "..dice[3].." = "..dicesumSimple.."; "..wordValue[dice[1]+dice[2]+dice[3]].."\nWeapon: "..weaponValue.."\nArmor: "..armorValue.."\nFood: "..foodValue.."\nFinal: "..dicesumFinalAttack.."; "..hurtMessage)
				nut.util.notify(("You have been hit with "..dicesumFinalAttack.."; "..hurtMessage), entity)
				client.nutNextPM = CurTime() + 0.5
			elseif (arguments[1] == "dodge") then
				nut.chat.send(client, "roll", "...\n\nDice: "..dice[1]..", "..dice[2]..", "..dice[3].." = "..dicesumSimple.."; "..wordValue[dice[1]+dice[2]+dice[3]].."\nFood: "..foodValue.."\nStamina: "..staminaValue.."\nFinal: "..dicesumFinalDodge)
				nut.util.notify(("You have been hit with "..dicesumFinalDodge.."; "..hurtMessage), entity)
			else
				client:notifyLocalized("Please specify attack or dodge.")
			end
		else
			client:notifyLocalized("You are not looking at a valid player.")
		end
	end
})

nut.command.add("roll", {
	onRun = function(client, arguments)
		--Standard rolling
		local dice1 = math.random(-1, 1)
		local dice2 = math.random(-1, 1)
		local dice3 = math.random(-1, 1)
		local dicesum = dice1+dice2+dice3

		nut.chat.send(client, "roll", dice1..", "..dice2..", "..dice3.." = "..dicesum.."; "..wordValue[dicesum])
		client.nutNextPM = CurTime() + 0.5
	end
})

nut.command.add("rollclassic", {
	syntax = "[number maximum]",
	onRun = function(client, arguments)
		nut.chat.send(client, "roll", math.random(0, math.min(tonumber(arguments[1]) or 100, 100)))
	end
})