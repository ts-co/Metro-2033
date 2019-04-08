ITEM.name = "Passport Base"
ITEM.desc = "A Passport"
ITEM.category = "Identification"
ITEM.model = "models/Gibs/HGIBS.mdl"
ITEM.faction = "Red Line"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 0
ITEM.permit = "passport"

ITEM.functions.Write = {
	menuOnly = true,
	onRun = function(item)
		net.Start("nutMetroPassportWrite")
		net.Send(item.player)
		id = item:getID()
		return false
	end,
	onCanRun = function(item)
		local class = nut.class.list[item.player:getChar():getClass()]
		return ((class.name == "Hanseatic League" && item.faction == "hanza") || (class.name == "Red Line" && item.faction == "redline") || (class.name == "Fourth Reich" && item.faction == "reich") || (class.name == "Leninsky Prospekt Militia" && item.faction == "militia") == true)
	end,
	icon = "icon16/book_edit.png"
}

ITEM.functions.Read = {
	menuOnly = true,
	onRun = function(item)
		item:sync(item.player)
		net.Start("OpenPassport")
		net.WriteUInt(item:getID(), 32)
		net.Send(item.player)
		return false
	end,
	icon = "icon16/book_open.png"
}

net.Receive("OpenPassport", function(len, client)
	local item = nut.item.instances[net.ReadUInt(32)]

		local background = Material("vgui/passports/passport_"..item.faction..".png", "noclamp smooth")
		local frame = vgui.Create("DFrame")
		frame:SetTitle("")
		frame:SetSize(1024, 665)
		frame:MakePopup()
		frame:ShowCloseButton(true)
		frame.Paint = function(self, w, h)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.SetMaterial(background)
			surface.DrawTexturedRect(0, 0, 1024, 665)
		end

		local code = frame:Add("DLabel")
		code:SetPos(620, 76)
		code:SetSize(250, 20)
		code:SetFont("nutGenericFont")
		code:SetText(item:getData("code", ""))
		code:SetTextColor(color_black)

		local authorized = frame:Add("DLabel")
		authorized:SetPos(205, 571)
		authorized:SetSize(250, 20)
		authorized:SetFont("nutGenericFont")
		authorized:SetText(item:getData("authorized", ""))
		authorized:SetTextColor(color_black)

		local name = frame:Add("DLabel")
		name:SetPos(620, 136)
		name:SetSize(250, 20)
		name:SetFont("nutGenericFont")
		name:SetText(item:getData("name", ""))
		name:SetTextColor(color_black)

		local dob = frame:Add("DLabel")
		dob:SetPos(608, 167)
		dob:SetSize(262, 20)
		dob:SetFont("nutGenericFont")
		dob:SetText(item:getData("dob", ""))
		dob:SetTextColor(color_black)

		local sex = frame:Add("DLabel")
		sex:SetPos(608, 196)
		sex:SetSize(262, 20)
		sex:SetFont("nutGenericFont")
		sex:SetText(item:getData("sex", ""))
		sex:SetTextColor(color_black)

		local nationality = frame:Add("DLabel")
		nationality:SetPos(692, 227)
		nationality:SetSize(178, 20)
		nationality:SetFont("nutGenericFont")
		nationality:SetText(item:getData("nationality", ""))
		nationality:SetTextColor(color_black)

		local issued = frame:Add("DLabel")
		issued:SetPos(640, 289)
		issued:SetSize(178, 20)
		issued:SetFont("nutGenericFont")
		issued:SetText(item:getData("issued", ""))
		issued:SetTextColor(color_black)

		local info = frame:Add("DLabel")
		info:SetPos(580, 351)
		info:SetSize(300, 230)
		info:SetFont("nutGenericFont")
		info:SetText(item:getData("info", ""))
		info:SetTextColor(color_black)
end)

net.Receive("nutMetroPassportSend", function(len, client)
	local item = nut.item.instances[id]
	local name = net.ReadString()
	local dob = net.ReadString()
	local sex = net.ReadString()
	local nationality = net.ReadString()
	local issued = net.ReadString()
	local info = net.ReadString()
	local authorized = net.ReadString()
	local code = net.ReadString()

	item:setData("name", name)
	item:setData("dob", dob)
	item:setData("sex", sex)
	item:setData("nationality", nationality)
	item:setData("issued", issued)
	item:setData("info", info)
	item:setData("authorized", authorized)
	item:setData("code", code)
end)