extends Label


var ammo = 0
var health = 0

func update_ammo(amnt):
	self.ammo = amnt
	update_display()

func update_health(amnt):
	self.health = amnt
	update_display()

func update_display():
	self.text = "Health: " + str(self.health)
	var ammo_amnt = str(ammo)
	if ammo < 0:
		ammo_amnt = "-"
	self.text += "\nAmmo: " + ammo_amnt
