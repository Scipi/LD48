extends Spatial

onready var proj_emitters = $proj_emitters.get_children()

export var automatic = false

var fire_point: Spatial
var bodies_to_exclude: Array = []

export var damage = 5
export var melee = false
export var ammo = 30

export var attack_rate = 1.0
var attack_timer: Timer
var can_attack = true

signal equipped
signal fired
signal out_of_ammo

onready var relic_manager = get_tree().get_nodes_in_group("relic_manager")[0]

func _ready():
	self.attack_timer = Timer.new()
	self.attack_timer.wait_time = self.attack_rate
	self.attack_timer.connect("timeout", self, "finish_attack")
	self.attack_timer.one_shot = true
	self.add_child(self.attack_timer)
	
func init(_fire_point: Spatial, _bodies_to_exlude: Array):
	self.fire_point = _fire_point
	self.bodies_to_exclude = _bodies_to_exlude
	for e in self.proj_emitters:
		e.set_damage(self.damage)
		e.set_bodies_to_exclude(self.bodies_to_exclude)
		
func attack(attack_input_just_pressed: bool, attack_input_held: bool):
	if !self.can_attack:
		return
	if self.automatic and !attack_input_held:
		return
	if !self.automatic and !attack_input_just_pressed:
		return
	
	if self.ammo == 0 and !self.melee:
		if attack_input_just_pressed:
			emit_signal("out_of_ammo")
		return
	
	if ammo > 0 and !self.melee:
		if relic_manager.active_relics[4]:
			ammo -= 2
		else:
			ammo -= 1
	
	var start_transform = $proj_emitters.global_transform
	$proj_emitters.global_transform = self.fire_point.global_transform
	
	for e in self.proj_emitters:
		e.attack()
	$proj_emitters.global_transform = start_transform
	# $AnimationPlayer.stop()
	# $AnimationPlayer.play("attack")
	$AnimationTree["parameters/attack_os/active"] = true
	emit_signal("fired")
	self.can_attack = false
	self.attack_timer.start()

func finish_attack():
	self.can_attack = true

func set_active():
	show()
	emit_signal("equipped")

func set_inactive():
	$AnimationTree["parameters/attack_os/active"] = false
	hide()
