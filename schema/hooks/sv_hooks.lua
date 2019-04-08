function SCHEMA:PlayerSpawn(client)
	if (client:getChar()) then
		client:getChar():joinClass(3)
	end
end

function SCHEMA:PlayerSpray(client) -- Disables the ability to spray
    return true
end

function SCHEMA:PlayerSwitchFlashlight(ply, on) -- Enables Flashlight
	return true
end

--[[
function SCHEMA:OnCharVarChanged(character, key, oldValue, value) -- Not currently using, but it's a very helpful function we could use in the future.
	if (key == "model" and IsValid(character:getPlayer())) then
	end
end
--]]