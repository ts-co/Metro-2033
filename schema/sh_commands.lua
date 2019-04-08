if (SERVER) then
	util.AddNetworkString("OpenInvMenu")
	util.AddNetworkString("OpenRoster")

	function ItemCanEnterForEveryone(inventory, action, context)
		if (action == "transfer") then
			return true
		end
	end

	function CanReplicateItemsForEveryone(inventory, action, context)
		if (action == "repl") then
			return true
		end
	end
end

	nut.command.add("checkinventory", {
		adminOnly = true,
		syntax = "<string target>",
		onRun = function(client, arguments)
			local target = nut.command.findPlayer(client, arguments[1])
			if (IsValid(target) and target:getChar() and target != client) then
				local inventory = target:getChar():getInv()
				inventory:addAccessRule(ItemCanEnterForEveryone, 1)
				inventory:addAccessRule(CanReplicateItemsForEveryone, 1)
				inventory:sync(client)
				net.Start("OpenInvMenu")
				net.WriteEntity(target)
				net.WriteType(inventory:getID())
				net.Send(client)
			elseif (target == client) then
				client:notifyLocalized("This isn't meant for checking your own inventory.")
			end
		end
	})

	nut.command.add("roster", {
		onRun = function(client, arguments)
			local class = nut.class.list[client:getChar():getClass()]
			if (IsValid(client) and client:getChar()) then
				net.Start("OpenRoster")
				net.WriteEntity(client)
				net.Send(client)
			end
		end
	})

	nut.command.add("chargetmoney", {
		adminOnly = true,
		syntax = "<string target>",
		onRun = function(client, arguments)
			local target = nut.command.findPlayer(client, arguments[1])
			local character = target:getChar()
			client:notifyLocalized(character:getName().." has "..character:getMoney().." bullets.")
		end
	})

if (CLIENT) then
	net.Receive("OpenInvMenu", function()
		local target = net.ReadEntity()
		local index = net.ReadType()

		local targetInv = nut.inventory.instances[index]
		local myInv = LocalPlayer():getChar():getInv()

		local inventoryDerma = targetInv:show()
		inventoryDerma:SetTitle(target:getChar():getName().."'s Inventory")
		inventoryDerma:MakePopup()
		inventoryDerma:ShowCloseButton(true)

		local myInventoryDerma = myInv:show()
		myInventoryDerma:MakePopup()
		myInventoryDerma:ShowCloseButton(true)
		myInventoryDerma:SetParent(inventoryDerma)
		myInventoryDerma:MoveLeftOf(inventoryDerma, 4)
	end)

	net.Receive("OpenRoster", function()
		local client = net.ReadEntity()
		local class = nut.class.list[client:getChar():getClass()]
		local frame = vgui.Create("DFrame")
		frame:SetSize(ScrW() * nut.config.get("sbWidth"), ScrH() * nut.config.get("sbHeight"))
		frame:Center()
		frame:SetTitle("Roster")
		frame:MakePopup()

		local rosterList = frame:Add("DListView")
		rosterList:Dock(FILL)
		rosterList:SetMultiSelect(false)
		if (client:getChar()) then
			if (class) then
				rosterList:AddColumn(class.name)
				for k, v in pairs(nut.class.getPlayers(client:getChar():getClass())) do
					rosterList:AddLine(v:getChar():getName())
				end
			else
				rosterList:AddColumn("None")
			end
		end
	end)
end