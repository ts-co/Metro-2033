ITEM.name = "Map"
ITEM.desc = "A map of the Metro"
ITEM.model = "models/metro2033/map.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Equipment"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(413.59942626953, 350.11785888672, 245.88780212402),
	ang = Angle(25, 220, 0),
	fov = 2.652303847665,
}
ITEM.contents = [[
<img src="https://i.imgur.com/wqD7NBW.png" width="795" height="1038">
]]
ITEM.functions.Read = {
	onClick = function(item)
		local frame = vgui.Create("DFrame")
		frame:SetSize(835, 680)
		frame:SetTitle(item.name)
		frame:MakePopup()
		frame:Center()

		frame.html = frame:Add("DHTML")
		frame.html:Dock(FILL)
		frame.html:SetHTML([[<html><body style="background-color: #ECECEC; color: #282B2D; font-family: 'Book Antiqua', Palatino, 'Palatino Linotype', 'Palatino LT STD', Georgia, serif; font-size 16px; text-align: justify;">]]..item.contents..[[</body></html>]])
	end,
	onRun = function(item)
		return false
	end,
	icon = "icon16/image.png"
}

function ITEM:onGetDropModel(item) return "models/props_c17/paper01.mdl" end