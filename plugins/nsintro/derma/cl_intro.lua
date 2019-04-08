local gradient = nut.util.getMaterial("vgui/gradient-r.vtf")
local glow = surface.GetTextureID("particle/Particle_Glow_04_Additive")
local introVideo = surface.GetTextureID("nutscript/gui/introVideo")

local PANEL = {}
	function PANEL:Init()

		if (IsValid(nut.gui.intro)) then
			nut.gui.intro:Remove()
		end

		nut.gui.intro = self

		self:SetSize(ScrW(), ScrH())
		self:SetZPos(9999)

		timer.Simple(0.1, function()
			if (!IsValid(self)) then
				return
			end

			self.sound = CreateSound(LocalPlayer(), "music/hl1_song20.mp3")
			self.sound:Play()
			self.sound:ChangePitch(80, 0)
		end)

		surface.CreateFont("BebasTitle", {
			font = "BEBAS",
			size =  ScreenScale(50),
			weight = 500
		})

		self.authors = self:Add("DLabel")
		self.authors:SetText("Voluntary Gaming")
		self.authors:SetFont("BebasTitle")
		self.authors:SetTextColor(color_white)
		self.authors:SetAlpha(0)
		self.authors:AlphaTo(255, 3, 1.5, function()
			self.authors:AlphaTo(255, 3, 0.5, function()
				if (self.sound) then
					self.sound:FadeOut(8)
					self.sound:FadeOut(8)
				end

				self.authors:AlphaTo(0, 3, 1, function()
					LocalPlayer():EmitSound("music/hl2_song10.mp3", 150, 70)
				end)
				self.name:AlphaTo(255, 7.5, 5)
				--self.schema:AlphaTo(255, 7.5, 5)
			end)
		end)
		self.authors:SizeToContents()
		self.authors:Center()
		self.authors:SetZPos(99)

		self.name = self:Add("DLabel")
		self.name:SetText("Metro 2033")
		self.name:SetFont("BebasTitle")
		self.name:SetTextColor(color_white)
		self.name:SizeToContents()
		self.name:Center()
		--self.name:SetPos(self.name.x, ScrH() * 0.4)
		self.name:SetPos(ScrW() * 0.045, ScrH() * 0.3)
		self.name:SetAlpha(0)

		--[[
		self.schema = self:Add("DLabel")
		self.schema:SetText("Serious Roleplay")
		self.schema:SetFont("BebasSubTitle")
		self.schema:SizeToContents()
		self.schema:SetPos(ScrW() * 0.045, 0)
		self.schema:MoveBelow(self.name, 10)
		self.schema:SetTextColor(Color(255, 0, 0))
		self.schema:SetAlpha(0)
		--]]

		timer.Simple(5, function()
			if (IsValid(self)) then
				self:addContinue()
			end
		end)
	end

	function PANEL:addContinue()
		self.info = self:Add("DLabel")
		self.info:Dock(BOTTOM)
		self.info:SetTall(36)
		self.info:DockMargin(0, 0, 0, 32)
		self.info:SetText("Press Space to continue...")
		self.info:SetFont("nutIntroSmallFont")
		self.info:SetContentAlignment(2)
		self.info:SetAlpha(0)
		self.info:AlphaTo(255, 1, 0, function()
			self.info.Paint = function(this)
				this:SetAlpha(math.abs(math.cos(RealTime() * 0.8) * 255))
			end
		end)
		self.info:SetExpensiveShadow(1, color_black)
	end

	function PANEL:Think()
		if (IsValid(self.info) and input.IsKeyDown(KEY_SPACE) and !self.closing) then
			self.closing = true
			self:AlphaTo(0, 2.5, 0, function()
				self:Remove()
			end)
		end
	end

	function PANEL:OnRemove()
		if (self.sound) then
			self.sound:Stop()
			self.sound = nil

			if (IsValid(nut.gui.char)) then
				nut.gui.char:playMusic()
			end
		end
	end

	function PANEL:Paint(w, h)
		surface.SetDrawColor(0, 0, 0)
		surface.SetTexture(introVideo)
		surface.DrawRect(0, 0, w, h)
	end

vgui.Register("nutIntro", PANEL, "EditablePanel")