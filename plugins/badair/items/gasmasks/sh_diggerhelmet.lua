ITEM.name = "Digger Helmet"
ITEM.model = "models/maver1k_xvii/metro_digger_helmet.mdl"
ITEM.width = 1
ITEM.height = 1
 
ITEM.price = 250

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
				},
				["self"] = {
					["Angles"] = Angle(0.000, -90.000, -90.000),
					["UniqueID"] = "2827706147",
					["ClassName"] = "model",
					["Size"] = 1.1,
					["EditorExpand"] = true,
					["Model"] = "models/maver1k_xvii/metro_digger_helmet.mdl",
					["Position"] = Vector(2.161804, -3.669312, 0.008423),
				},
			},
		},
		["self"] = {
			["EditorExpand"] = true,
			["UniqueID"] = "DIGGER_MODEL",
			["ClassName"] = "group",
			["Name"] = "digger",
			["Description"] = "add parts to me!",
		},
	},

}


local txtTable = {
	{math.huge, "txtCond0"},
	{75, "txtCond1"},
	{50, "txtCond2"},
	{25, "txtCond3"},
	{0.1, "txtCond4"}
}

function ITEM:getDesc()
	if (self.entity) then
		return L"diggerDescEntity"
	else
		local fineHealthText = "ERROR"

		for _, b in pairs(txtTable) do
			if (b[1] > self:getHealth()) then
				fineHealthText = L(b[2])
			end
		end

		local filter = tonumber(self:getFilter()) or 0 -- lol debugging

		return L("diggerDesc",
			fineHealthText, self:getHealth() .. "%",
			L(filter <= 0 and "txtFail" or "txtFunc"), self:getFilter()
		)
	end
end