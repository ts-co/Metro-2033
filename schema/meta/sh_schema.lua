SCHEMA.disabledPlugins = SCHEMA.disabledPlugins or {}

--Disable plugins
function SCHEMA:DisablePlugin(uniqueID)
	self.disabledPlugins[uniqueID] = true
end

function SCHEMA:PluginShouldLoad(uniqueID)
	return ( !self.disabledPlugins[uniqueID] )
end

--Override default config
function SCHEMA:OverrideConfig(key, value)
	local cfg = nut.config.stored[key]

	if (cfg) then
		cfg.default = value
	end
end