ITEM.name = "Fourth Reich Hazmat Suit"
ITEM.model = "models/cultist_kun/reich_stalker1.mdl"
ITEM.iconCam = {
	pos = Vector(-200, 0.77698647975922, 48.242790222168),
	ang = Angle(0, -0, 0),
	fov = 11.789551553782,
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
		return L"hazmatreichDescEntity"
	else
		local fineHealthText = "ERROR"

		for _, b in pairs(txtTable) do
			if (b[1] > self:getHealth()) then
				fineHealthText = L(b[2])
			end
		end

		local filter = tonumber(self:getFilter()) or 0 -- lol debugging

		return L("hazmatreichDesc",
			fineHealthText, self:getHealth() .. "%",
			L(filter <= 0 and "txtFail" or "txtFunc"), self:getFilter()
		)
	end
end

ITEM.replacements = "models/cultist_kun/reich_stalker1.mdl"