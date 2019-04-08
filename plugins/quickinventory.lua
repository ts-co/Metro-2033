--VERSION SUPPORT: 1.1-beta

PLUGIN.name = "Quick Inventory"
PLUGIN.author = "Pilot"
PLUGIN.desc = "F4 key to open your inventory."

if (SERVER) then
	util.AddNetworkString("OpenMyInv")

	local function ItemCanEnterForEveryone(inventory, action, context)
		if (action == "transfer") then
			return true
		end
	end

	local function CanReplicateItemsForEveryone(inventory, action, context)
		if (action == "repl") then
			return true
		end
	end

	function PLUGIN:ShowSpare2(client)
		local inventory = client:getChar():getInv()
		inventory:addAccessRule(ItemCanEnterForEveryone)
		inventory:addAccessRule(CanReplicateItemsForEveryone)
		net.Start("OpenMyInv")
		net.Send(client)
	end
else
	net.Receive("OpenMyInv", function()
		local myInv = LocalPlayer():getChar():getInv()

		local myInventoryDerma = myInv:show()
		myInventoryDerma:MakePopup()
		myInventoryDerma:ShowCloseButton(true)
	end)
end