local PANEL = {}

local traits = {}
traits[1] = {"Red Line Citizen", "After Anatoly Moskvin died and Maxim came into power you sensed a rather dark path overtaking the Red Line. As purges and mass conscription began at your home station, you decided to leave the Red Line and scour the Metro."}
traits[2] = {"Fourth Reich Citizen", "You grew up around Tverskaya and watched one small gang of Neo-Nazis grow into a small power military. Life was scary - but, clean and safe. Everyone was somewhat well disciplined, and always looked presentable. You managed to escape the Fourth Reich for your own reasons, and decided to scour the Metro."}
traits[3] = {"Hanza Citizen", "After the world was destroyed you were lucky enough to grow up within the Ring. For the most part you lived a life of comfort and luxury, always having something to work for - however, now you've decided to out and explore what you could only see behind a metal door and scour the Metro."}
traits[4] = {"Leninsky Citizen", "You grew up in a small farming station. No one ever really bothered you, except the occassional creatures of the Metro and bandits. That seemed to all turn around when the Red Line came knocking, and rumors of the Fourth Reich with it - as a result you went out to scour the Metro."}

function PANEL:Init()
	self.title = self:addLabel("Select a trait")

	self.faction = self:Add("DComboBox")
	self.faction:SetFont("nutCharButtonFont")
	self.faction:Dock(TOP)
	self.faction:DockMargin(0, 4, 0, 0)
	self.faction:SetTall(40)
	self.faction.Paint = function(faction, w, h)
		nut.util.drawBlur(faction)
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawRect(0, 0, w, h)
	end
	self.faction:SetTextColor(color_white)
	self.faction.OnSelect = function(faction, index, value, id)
		self:onTraitSelected(index)
	end

	self.desc = self:addLabel("desc")
	self.desc:DockMargin(0, 8, 0, 0)
	self.desc:SetFont("nutCharSubTitleFont")
	self.desc:SetWrap(true)
	self.desc:SetAutoStretchVertical(true)
	self.desc:SetText("")

	for index, trait in pairs(traits) do
		self.faction:AddChoice(trait[1])
	end
end

function PANEL:onTraitSelected(trait)
	for k, v in pairs(traits) do
		if k == trait then
			self.desc:SetText(v[2])
			self:setContext("trait", trait)
		end
	end
	nut.gui.character:clickSound()
end

vgui.Register("nutCharacterTraits", PANEL, "nutCharacterCreateStep")
