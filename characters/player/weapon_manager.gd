extends Spatial


onready var weapons = $weapons.get_children()
var current_weapon_id = 1  # Sword
var current_weapon = null

var fire_point: Spatial
var bodies_to_exclude: Array = []


func init(_fire_point: Spatial, _bodies_to_exclude: Array):
	self.fire_point = _fire_point
	self.bodies_to_exclude = _bodies_to_exclude
	for w in self.weapons:
		if w.has_method("init"):
			w.init(_fire_point, _bodies_to_exclude)
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
	

func next_weapon():
	switch_weapon((self.current_weapon_id + 1) % len(self.weapons))

func prev_weapon():
	switch_weapon(posmod(self.current_weapon_id - 1, len(self.weapons)))

func disable_all_weapons():
	for weapon in self.weapons:
		if weapon.has_method('set_inactive'):
			weapon.set_inactive()
		else:
			weapon.hide()
