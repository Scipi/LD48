extends Spatial


# onready var weapons = $weapons.get_children()
var current_weapon_id = 1  # Sword
var current_weapon = null

enum WEAPON_TYPES {
	FISTS = 0,
	SWORD = 1,
	BOW = 2
}

onready var weapons = {
	WEAPON_TYPES.FISTS: get_node("weapons/fists"),
	WEAPON_TYPES.SWORD: get_node("weapons/sword"),
	WEAPON_TYPES.BOW: get_node("weapons/bow")
}


var fire_point: Spatial
var bodies_to_exclude: Array = []

signal ammo_changed

func init(_fire_point: Spatial, _bodies_to_exclude: Array):
	self.fire_point = _fire_point
	self.bodies_to_exclude = _bodies_to_exclude
	for w in self.weapons.values():
		if w.has_method("init"):
			w.init(_fire_point, _bodies_to_exclude)
	
	for w in self.weapons.values():
		w.connect("fired", self, "emit_ammo_changed_signal")
		
	switch_weapon(1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func attack(attack_input_just_pressed: bool, attack_input_held: bool):
	if self.current_weapon.has_method("attack"):
		self.current_weapon.attack(attack_input_just_pressed, attack_input_held)


func switch_weapon(id):
	if id < 0 or id >= len(self.weapons):
		return

	self.current_weapon_id = id
	
	disable_all_weapons()
	
	self.current_weapon = self.weapons[id]
	if self.current_weapon.has_method('set_active'):
		self.current_weapon.set_active()
	else:
		self.current_weapon.show()
	
	emit_ammo_changed_signal()
	

func next_weapon():
	switch_weapon((self.current_weapon_id + 1) % len(self.weapons))

func prev_weapon():
	switch_weapon(posmod(self.current_weapon_id - 1, len(self.weapons)))

func disable_all_weapons():
	for weapon in self.weapons.values():
		if weapon.has_method('set_inactive'):
			weapon.set_inactive()
		else:
			weapon.hide()

func get_pickup(pickup_type, value):
	match pickup_type:
		Pickup.PICKUP_TYPES.ARROW:
			var w = self.current_weapon_id
			switch_weapon(WEAPON_TYPES.BOW)
			self.current_weapon.ammo += value
			switch_weapon(w)

func emit_ammo_changed_signal():
	emit_signal("ammo_changed", current_weapon.ammo)
