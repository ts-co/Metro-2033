-- This function will prevent displaying crosshair with certain weapons
function SCHEMA:ShouldDrawCrosshair()
	local client = LocalPlayer()
	local weapon = client:GetActiveWeapon()

	if (weapon and weapon:IsValid()) then
		local class = weapon:GetClass()
		
		if (class:find("cw_") or class:find("wf_")) then
			return false
		end
	end
end