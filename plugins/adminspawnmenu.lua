--VERSION SUPPORT: 1.1, 1.1-beta

PLUGIN.name = "Admin Spawn Menu"
PLUGIN.author = "Pilot"
PLUGIN.desc = "Allow admins to easily spawn items."

if (SERVER) then
	util.AddNetworkString("adminSpawnMenu")
	util.AddNetworkString("adminSpawnItem")

	net.Receive("adminSpawnItem", function(len, client)
		if (!client:IsAdmin()) then return end
		
		local uniqueID = net.ReadString()
		for k, v in pairs(nut.item.list) do
			if v.uniqueID == uniqueID then
				nut.item.spawn(v.uniqueID, client:GetShootPos() + client:GetAimVector()*84 + Vector(0, 0, 16))
				nut.log.add(client:getChar():getName(), "has spawned ", v.name)
			end
		end
	end)
end

nut.command.add("adminspawnmenu", {
    adminOnly = true,
	onRun = function(client, arguments)
		net.Start("adminSpawnMenu")
		net.Send(client)
	end
})

if (CLIENT) then
	net.Receive("adminSpawnMenu",function()
		local background = vgui.Create("DFrame")
		background:SetSize(ScrW() / 2, ScrH() / 2)
		background:Center()
		background:SetTitle("Admin Spawn Menu")
		background:MakePopup()
		background:ShowCloseButton(true)

		scroll = background:Add("DScrollPanel")
		scroll:Dock(FILL)

		categoryPanels = {}

		for k, v in pairs(nut.item.list) do
			if (!categoryPanels[L(v.category)]) then
				categoryPanels[L(v.category)] = v.category
			end
		end
		
		for category, realName in SortedPairs(categoryPanels) do
			local collapsibleCategory = scroll:Add("DCollapsibleCategory")
			collapsibleCategory:SetTall(36)
			collapsibleCategory:SetLabel(category)
			collapsibleCategory:Dock(TOP)
			collapsibleCategory:SetExpanded(0)
			collapsibleCategory:DockMargin(5, 5, 5, 0)
			collapsibleCategory.category = realName

			for k, v in pairs(nut.item.list) do
				if v.category == collapsibleCategory.category then
					local item = collapsibleCategory:Add("DButton")
					item:SetText(v.name)
					item:SizeToContents()
					item.DoClick = function()
						net.Start("adminSpawnItem")
						net.WriteString(v.uniqueID)
						net.SendToServer()
						surface.PlaySound("buttons/button14.wav")
					end
				end
			end

			categoryPanels[realName] = collapsibleCategory
		end
	end)
end