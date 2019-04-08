ITEM.name = "Based Gas Mask"
ITEM.model = "models/half-dead/metrollfix/p_mask_1.mdl"
ITEM.width = 2
ITEM.height = 2

ITEM.isGasMask = true
ITEM.price = 250
ITEM.category = "Outfit"
ITEM.outfitCategory = "model"

ITEM.replacements = "models/manhack.mdl"

function ITEM:onGetDropModel(item) return "models/props_c17/SuitCase_Passenger_Physics.mdl" end

local txtTable = {
	{math.huge, "txtCond0"},
	{75, "txtCond1"},
	{50, "txtCond2"},
	{25, "txtCond3"},
	{0.1, "txtCond4"}
}

function ITEM:getDesc()
	if (self.entity) then
		return L"hazmatDescEntity"
	else
		local fineHealthText = "ERROR"

		for _, b in pairs(txtTable) do
			if (b[1] > self:getHealth()) then
				fineHealthText = L(b[2])
			end
		end

		local filter = tonumber(self:getFilter()) or 0 -- lol debugging

		return L("hazmatDesc",
			fineHealthText, self:getHealth() .. "%",
			L(filter <= 0 and "txtFail" or "txtFunc"), self:getFilter()
		)
	end
end

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		if (item:getData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
end

function ITEM:isEquipped()
	return self:getData("equip", false)
end

function ITEM:getHealth()
	return self:getData("health", DEFAULT_GASMASK_HEALTH)
end

function ITEM:damageHealth(amount)
	self:setData("health", math.max(0, self:getHealth() - amount))
end

function ITEM:getFilter()
	return self:getData("filter", DEFAULT_GASMASK_FILTER)
end

function ITEM:damageFilter(amount)
	self:setData("filter", math.max(0, self:getFilter() - amount))
end

local function playerGasmask(client, item, bool)
	local char = client:getChar()

	if (bool) then
		client.nutGasMaskItem = item
		client:addPart(item.uniqueID)

		netstream.Start(client, "nutMaskOn", item:getID(), item:getHealth()) 
	else
		client.nutGasMaskItem = nil
		client:removePart(item.uniqueID)

		netstream.Start(client, "nutMaskOff")
	end

	item:setData("equip", bool)
	item.player:EmitSound(bool and "gasmaskon.wav" or "gasmaskoff.wav", 80)
	client:ScreenFade(1, Color(0, 0, 0, 255), 1, 0)
end

function ITEM:removeOutfit(client)
	local character = client:getChar()
	
	self:setData("equip", false)

	if (character:getData("oldMdl")) then
		character:setModel(character:getData("oldMdl"))
		character:setData("oldMdl", nil)
	end

	if (self.newSkin) then
		if (character:getData("oldSkin")) then
			client:SetSkin(character:getData("oldSkin"))
			character:setData("oldSkin", nil)
		else
			client:SetSkin(0)
		end
	end

	for k, v in pairs(self.bodyGroups or {}) do
		local index = client:FindBodygroupByName(k)

		if (index > -1) then
			client:SetBodygroup(index, 0)

			local groups = character:getData("groups", {})

			if (groups[index]) then
				groups[index] = nil
				character:setData("groups", groups)
			end
		end
	end

	if (self.attribBoosts) then
		for k, _ in pairs(self.attribBoosts) do
			character:removeBoost(self.uniqueID, k)
		end
	end
end

ITEM:hook("drop", function(item)
	if (item:isEquipped()) then
		local client = item.player
		item:removeOutfit(item.player)

		playerGasmask(client, item, false)
	end
end)

ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Unequip",
	tip = "unequipTip",
	icon = "icon16/cross.png",
	onRun = function(item)		
		playerGasmask(item.player, item, false)
		item:removeOutfit(item.player)
		
		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:isEquipped())
	end
}

ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
	onRun = function(item)
		local char = item.player:getChar()
		local items = char:getInv():getItems()
		local client = item.player

		if (client.nutGasMaskItem) then
			client:notifyLocalized("maskEquipped")

			return false
		end

		for k, v in pairs(items) do
			if (v.id != item.id) then
				local itemTable = nut.item.instances[v.id]

				if (itemTable.pacData and v.outfitCategory == item.outfitCategory and itemTable:getData("equip")) then
					item.player:notify("You're already equipping this kind of outfit")

					return false
				end
			end
		end

		item:setData("equip", true)

		if (type(item.onGetReplacement) == "function") then
			char:setData("oldMdl", char:getData("oldMdl", item.player:GetModel()))
			char:setModel(item:onGetReplacement())
		elseif (item.replacement or item.replacements) then
			char:setData("oldMdl", char:getData("oldMdl", item.player:GetModel()))

			if (type(item.replacements) == "table") then
				if (#item.replacements == 2 and type(item.replacements[1]) == "string") then
					char:setModel(item.player:GetModel():gsub(item.replacements[1], item.replacements[2]))
				else
					for k, v in ipairs(item.replacements) do
						char:setModel(item.player:GetModel():gsub(v[1], v[2]))
					end
				end
			else
				char:setModel(item.replacement or item.replacements)
			end
		end

		if (item.newSkin) then
			char:setData("oldSkin", item.player:GetSkin())
			item.player:SetSkin(item.newSkin)
		end

		if (item.bodyGroups) then
			local groups = {}

			for k, value in pairs(item.bodyGroups) do
				local index = item.player:FindBodygroupByName(k)

				if (index > -1) then
					groups[index] = value
				end
			end

			local newGroups = char:getData("groups", {})

			for index, value in pairs(groups) do
				newGroups[index] = value
				item.player:SetBodygroup(index, value)
			end

			if (table.Count(newGroups) > 0) then
				char:setData("groups", newGroups)
			end
		end

		if (item.attribBoosts) then
			for k, v in pairs(item.attribBoosts) do
				char:addBoost(item.uniqueID, k, v)
			end
		end

		-- INITIALIZE TEMP MASKVARS
		playerGasmask(client, item, true)
		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and !item:isEquipped())
	end
}

local function changeFilter(client, item, targetItem)
	if (item and targetItem and targetItem.isFilter) then
		if (targetItem.onChangeFilter) then
			targetItem:onChangeFilter(item, targetItem)
		end

		local filter = targetItem:getFilterHealth()
		item:setData("filter", filter)
		
        client:notifyLocalized("filterChanged")
		return true
	end

	return false
end

-- for external use.
function ITEM:changeFilter(client, item, targetItem)
	if (item:canChangeFilter()) then
		return changeFilter(client, item, targetItem)
	else
		client:notifyLocalized("maskFull")
		
		return false
	end
end

function ITEM:canChangeFilter()
	return (self:getHealth() > 0 and self:getFilter() < DEFAULT_GASMASK_FILTER)
end

ITEM.functions.Filter = {
	name = "Change Filter",
	tip = "filterTip",
	icon = "icon16/wrench.png",
	isMulti = true,
	multiOptions = function(item, client)
		local char = client:getChar()
		local inv = char:getInv()
		local items = inv:getItems()
		local result = {}

		for k, v in pairs(items) do
			if (v.isFilter) then
				table.insert(result, {
					name = Format("%s (%s)", v.name, v:getFilterHealth() or 0),
					data = v:getID()
				})
			end
		end

		return result
	end,
	onRun = function(item, data)
		local client = item.player
		if (item:canChangeFilter()) then
			local char = client:getChar()
			local inv = char:getInv()
			local items = inv:getItems()
			local target

			if (data) then
				target = nut.item.instances[data]
				
				if (!items[target.id]) then
					return false -- stop hacking you dumb fuck
				end
			else
				for k, invItem in pairs(items) do
					if (invItem.isFilter) then
						target = invItem
						
						break
					end
				end
			end

			if (target) then
				if (changeFilter(client, item, target)) then
					target:remove()
				end
			else
				client:notifyLocalized("noFilter")
			end
		else
			client:notifyLocalized("maskFull")
		end

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:canChangeFilter())
	end
}

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory and self:getData("equip")) then
		return false
	end

	return true
end

-- Called when a new instance of this item has been made.
function ITEM:onInstanced(invID, x, y)
	self:setData("equip", false)
	self:setData("health", DEFAULT_GASMASK_HEALTH)
	self:setData("filter", DEFAULT_GASMASK_FILTER)
end