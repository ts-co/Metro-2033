nut.talk = nut.talk or {}
nut.talk.list = nut.talk.list or {}

-- Adds a talk that does something when set.
function nut.talk.add(talk, code, callback)
	-- Add the talk to a list, storing the description and callback (if there is one).
	nut.talk.list[talk] = {code = code}
end

--nut.talk.add("german", "de")

if (SERVER) then
	-- Called to apply talks when a player has spawned.
	--[[
	function nut.talk.onSpawn(client)
		-- Check if they have a valid character.
		if (client:getChar()) then
			-- Get all of the character's talks.
			local talks = client:getChar():getTalks()

			for i = 1, #talks do
				-- Get each individual talk.
				local talk = talks:sub(i, i)
				local info = nut.talk.list[talk]

				-- Check if the talk has a callback.
				if (info and info.callback) then
					-- Run the callback, passing the player and true so they get whatever benefits.
					info.callback(client, true)
				end
			end
		end
	end
	--]]
end

do
	-- Extend the character metatable to allow talk giving/taking.
	local character = nut.meta.character

	-- Talks can only be set server-side.
	if (SERVER) then
		-- Set the talk data to the talk table.
		function character:setTalks(talks)
			table.insert(self:getTalks(), talks)
			self:setData("t", self:getTalks())
		end

		-- Add a talk to the talk string.
		function character:giveTalks(talks)
			--If string isn't nil and string doesn't already exist, add it
			if (talks != "") then
				if table.HasValue(self:getTalks(), talks) != true then
					self:setTalks(talks)
				end
			end
		end

		-- Remove the talks from the talk table.
		function character:takeTalks(talks)
			local TalkTable = self:getTalks()
			-- Get the individual talks within the talk string.
			if table.HasValue(TalkTable, talks) then
				for k, v in pairs(TalkTable) do
					if v == talks then
						TalkTable[k] = nil
					end
				end
			end
		end
	end

	-- Return the talk table.
	function character:getTalks()
		return self:getData("t", {})
	end

	-- Check if the talk table contains the talks specified.
	function character:hasTalks(talks)
		if table.HasValue(self:getTalks(), talks) then
			return true
		end

		return false
	end
end