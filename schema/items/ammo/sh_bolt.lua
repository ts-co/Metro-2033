ITEM.name = "Steel Bolts"
ITEM.model = "models/ninja/signalvariance/weapons/helsing_barrels.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(202.67483520508, 163.42178344727, 123.0219039917),
	ang = Angle(25, 220, 0),
	fov = 2.5663728649857,
}

ITEM.ammo = "sniperpenetratedround"
ITEM.maxQuantity = 16
ITEM.desc = "A quiver that contains 16 Steel bolts"
ITEM.price = 80

function ITEM:onGetDropModel(item) return "models/Items/CrossbowRounds.mdl" end