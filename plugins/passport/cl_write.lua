local PANEL = {}

local background = Material("vgui/passports/passport_blank.png", "noclamp smooth")

function PANEL:Init()
	self:SetTitle("")
	self:SetSize(1024, 665)
	self:MakePopup()
	self:ShowCloseButton(true)

	self.code = self:addTextEntry("code")
	self.code:SetPos(620, 74)
	self.code:SetSize(250, 20)
	self.code.onTabPressed = function()
		self.authorized:RequestFocus()
	end

	self.authorized = self:addTextEntry("authorized")
	self.authorized:SetPos(205, 570)
	self.authorized:SetSize(250, 20)
	self.authorized.onTabPressed = function()
		self.name:RequestFocus()
	end

	self.name = self:addTextEntry("name")
	self.name:SetPos(620, 135)
	self.name:SetSize(250, 20)
	self.name.onTabPressed = function()
		self.dob:RequestFocus()
	end

	self.dob = self:addTextEntry("dob")
	self.dob:SetPos(608, 166)
	self.dob:SetSize(262, 20)
	self.dob.onTabPressed = function()
		self.sex:RequestFocus()
	end

	self.sex = self:addTextEntry("sex")
	self.sex:SetPos(608, 195)
	self.sex:SetSize(262, 20)
	self.sex.onTabPressed = function()
		self.nationality:RequestFocus()
	end

	self.nationality = self:addTextEntry("nationality")
	self.nationality:SetPos(692, 226)
	self.nationality:SetSize(178, 20)
	self.nationality.onTabPressed = function()
		self.info:RequestFocus()
	end

	local format = "%d %B %Y"
	self.issued = self:Add("DLabel")
	self.issued:SetPos(640, 288)
	self.issued:SetSize(178, 20)
	self.issued:SetFont("nutGenericFont")
	self.issued:SetText(os.date(format, nut.date.get()))
	self.issued:SetTextColor(color_black)

	self.info = self:addNoteEditor("note")
	self.info:SetPos(580, 350)
	self.info:SetSize(300, 230)

	self.button = self:Add("DButton")
	self.button:SetText("FINISH")
	self.button:SetPos(100, 50)
	self.button:SetSize(50, 50)
	self.button.DoClick = function()
		net.Start("nutMetroPassportSend")
		net.WriteString(self.name:GetValue())
		net.WriteString(self.dob:GetValue())
		net.WriteString(self.sex:GetValue())
		net.WriteString(self.nationality:GetValue())
		net.WriteString(self.issued:GetValue())
		net.WriteString(self.info:GetValue())
		net.WriteString(self.authorized:GetValue())
		net.WriteString(self.code:GetValue())
		net.SendToServer()
		surface.PlaySound("garrysmod/ui_click.wav")
		self:Close()
	end
end

function PANEL:addTextEntry(contextName)
	local entry = self:Add("DTextEntry")
	entry:SetSize(250, 20)
	entry:SetFont("nutGenericFont")
	entry.Paint = self.paintTextEntry
	entry.OnValueChange = function(_, value)
		chat.PlaySound()
	end
	entry.OnKeyCodeTyped = function(name, keyCode)
		if (keyCode == KEY_TAB) then
			entry:onTabPressed()
			return true
		end
	end
	entry:SetUpdateOnType(true)
	return entry
end

function PANEL:addNoteEditor(contextName)
	local noteEditor = self:Add("DTextEntry")
	noteEditor:SetFont("nutGenericFont")
	noteEditor:SetMultiline(true)
	noteEditor:SetAllowNonAsciiCharacters(true)
	noteEditor.OnValueChange = function(_, value)
		chat.PlaySound()
	end
	noteEditor.Paint = self.paintTextEntry
	noteEditor:SetUpdateOnType(true)
	return noteEditor
end

function PANEL:paintTextEntry(w, h)
	surface.SetDrawColor(0, 0, 0, 0)
	surface.DrawRect(0, 0, w, h)
	self:DrawTextEntryText(color_black, color_black, color_black)
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(background)
	surface.DrawTexturedRect(0, 0, 1024, 665)
end

vgui.Register("nutMetroPassportWrite", PANEL, "DFrame")

net.Receive("nutMetroPassportWrite", function(len, client)
	panel = vgui.Create("nutMetroPassportWrite")
end)