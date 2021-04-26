extends Spatial

var blood_spray = preload("res://effects/blood_spray.tscn")
var gibs = preload("res://effects/gibs.tscn")

signal dead
signal hurt
signal healed
signal health_changed
signal gibbed

export var starting_max_health = 100
var cur_health = 1

export var gib_at = -10
export var enemy = false

var max_health = 0

onready var relic_manager = get_tree().get_nodes_in_group("relic_manager")[0]

func _ready():
	self.max_health = starting_max_health
	init()
	
func init():
	self.cur_health = self.max_health
	emit_signal("health_changed", self.cur_health)

func _process(delta):
	if relic_manager.active_relics[8] and not enemy:
		self.max_health = starting_max_health * 0.75
	else:
		self.max_health = starting_max_health
	
	if cur_health > max_health:
		cur_health = max_health
		emit_signal("health_changed", self.cur_health)
		


func hurt(damage: int, _dir: Vector3):
	spawn_blood(_dir)
	if self.cur_health <= 0:
		return
	
	self.cur_health -= damage
	
	if self.cur_health <= self.gib_at:
		spawn_gibs()
		emit_signal("gibbed")

	if self.cur_health <= 0:
		emit_signal('dead')
	else:
		emit_signal("hurt")
		
	emit_signal("health_changed", self.cur_health)

func heal(amount: int):
	if self.cur_health <= 0:
		return
	
	self.cur_health += amount
	self.cur_health = clamp(self.cur_health, 0, self.max_health)
	
	emit_signal("healed")
	emit_signal("health_changed", self.cur_health)


func spawn_blood(dir):
	var blood_spray_inst = blood_spray.instance()
	get_tree().get_root().add_child(blood_spray_inst)
	blood_spray_inst.global_transform.origin = global_transform.origin
	
	if dir.angle_to(Vector3.UP) < 0.00005:
		return
	if dir.angle_to(Vector3.DOWN) < 0.00005:
		blood_spray_inst.rotate(Vector3.RIGHT, PI)
		return
	
	var y = dir
	var x = y.cross(Vector3.UP)
	var z = x.cross(y)
	
	blood_spray_inst.global_transform.basis = Basis(x, y, z)

func spawn_gibs():
	var gibs_inst = gibs.instance()
	get_tree().get_root().add_child(gibs_inst)
	gibs_inst.global_transform.origin = global_transform.origin
	gibs_inst.enable_gibs()


func get_pickup(pickup_type, value):
	match pickup_type:
		Pickup.PICKUP_TYPES.HEALTH:
			heal(value)
