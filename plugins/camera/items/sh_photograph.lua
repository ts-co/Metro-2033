ITEM.name = "Photograph"
ITEM.desc = "A photograph that goes into a camera."
ITEM.model = "models/pilot/voluntarygaming/photograph.mdl"
ITEM.used = false
ITEM.image = ""

ITEM.functions.View = {
	onClick = function(item)
		local background = Material("vgui/camera/photograph.png", "noclamp smooth")

		local frame = vgui.Create("DFrame")
		frame:SetSize(542, 660)
		frame:SetTitle("")
		frame:MakePopup()
		frame:Center()
		frame:SetDraggable(true)
		frame:ShowCloseButton(true)
		frame.Paint = function(self, w, h)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.SetMaterial(background)
			surface.DrawTexturedRect(0, 0, 542, 660)
		end
		
		local readImage = ""
		if file.Read("nutscript/metro/images/image_"..item:getID()..".txt", "DATA") != nil then
			readImage = file.Read("nutscript/metro/images/image_"..item:getID()..".txt", "DATA")
		end

		local html = frame:Add("HTML")
		html:SetSize(499, 482)
		html:SetPos(20, 46)
		html:SetHTML([[
		<style type="text/css">
			body {
				margin: 0;
				padding: 0;
				overflow: hidden;
			}
			img {
				width: 100%;
				height: 100%;
				-webkit-filter: grayscale(100%);
				filter: grayscale(100%);
			}
		</style>
		
		<img src="data:image/jpeg;base64,]].. readImage ..[[">
		]])

	end,
	onRun = function(item)
		return false
	end,
	icon = "icon16/book_open.png"
}

--[[
ITEM.functions.Name = {
	onClick = function(item)
			frame = vgui.Create("DFrame")
			frame:SetSize(340, 100)
			frame:Center()
			frame:SetTitle("Photograph")
			frame:MakePopup()
			frame:SetDraggable(false)
			frame:ShowCloseButton(true)

			local nameLabel = frame:Add("DLabel")
			nameLabel:Dock(TOP)
			nameLabel:SetText("Name:")

			local nameEntry = frame:Add("DTextEntry")
			nameEntry:Dock(TOP)
			nameEntry:SetText(item:getData("name", ""))

			local finishEntry = frame:Add("DButton")
			finishEntry:Dock(BOTTOM)
			finishEntry:SetText("Finish")
			finishEntry.DoClick = function()
				netstream.Start("photographData", nameEntry:GetValue())
				frame:Close()
			end
	end,
	onRun = function(item)
		netstream.Hook("photographData", function(client, data)
			item.name = data
		end)
		return false
	end,
	icon = "icon16/book_add.png"
}
--]]