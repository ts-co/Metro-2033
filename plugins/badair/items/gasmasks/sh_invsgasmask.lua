ITEM.name = "Gas Mask (Invisible)"
ITEM.model = "models/half-dead/metrollfix/p_mask_1.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(135.05212402344, 113.14922332764, 84.426582336426),
	ang = Angle(25, 220, 0),
	fov = 3.6,
}

 
ITEM.price = 250

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
				},
				["self"] = {
					["Angles"] = Angle(0.000, 0.000, 0.000),
					["UniqueID"] = "842892277",
					["ClassName"] = "model",
					["Size"] = 0,
					["EditorExpand"] = true,
					["Model"] = "models/half-dead/metrollfix/p_mask_2.mdl",
					["Position"] = Vector(0.000, 0.000, 0.000),
				},
			},
		},
		["self"] = {
			["EditorExpand"] = true,
			["UniqueID"] = "INVSGASMASK_MODEL",
			["ClassName"] = "group",
			["Name"] = "invisible",
			["Description"] = "add parts to me!",
		},
	},

}