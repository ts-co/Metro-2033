ITEM.name = "Based Gas Mask"
ITEM.model = "models/half-dead/metrollfix/p_mask_1.mdl"
ITEM.width = 1
ITEM.height = 1

ITEM.isGasMask = true
ITEM.price = 250
ITEM.category = "Equipment"

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
				},
				["self"] = {
					["Angles"] = Angle(90.000, 0.000, 0.000),
					["UniqueID"] = "3148632732",
					["ClassName"] = "model",
					["Size"] = 1.05,
					["EditorExpand"] = true,
					["Model"] = "models/half-dead/metrollfix/p_mask_2.mdl",
					["Position"] = Vector(2.945381, -3.045883, -0.007935),
				},
			},
		},
		["self"] = {
			["EditorExpand"] = true,
			["UniqueID"] = "GASMASK_MODEL",
			["ClassName"] = "group",
			["Name"] = "ppm88",
			["Description"] = "add parts to me!",
		},
	},

}

function ITEM:onGetDropModel(item) return "models/props_junk/cardboard_box004a.mdl" end

local txtTable = {
	{math.huge, "txtCond0"},
	{75, "txtCond1"},
	{50, "txtCond2"},
	{25, "txtCond3"},
	{0.1, "txtCond4"}
}

function ITEM:getDesc()
	if (self.entity) then
		return L"gasMaskDescEntity"
	else
		local fineHealthText = "ERROR"

		for _, b in pairs(txtTable) do
			if (b[1] > self:getHealth()) then
				fineHealthText = L(b[2])
			end
		end

		local filter = tonumber(self:getFilter()) or 0 -- lol debugging

		return L("gasMaskDesc",
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

ITEM:hook("drop", function(item)
	if (item:isEquipped()) then
		local client = item.player
		
		playerGasmask(client, item, false)
	end
end)

ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Unequip",
	tip = "unequipTip",
	icon = "icon16/cross.png",
	onRun = function(item)		
		playerGasmask(item.player, item, false)

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
		local client = item.player

		if (client.nutGasMaskItem) then
			client:notifyLocalized("maskEquipped")

			return false
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