extends Spatial

signal dead
signal hurt
signal healed
signal health_changed
signal gibbed

export var max_health = 100
var cur_health = 1

export var gib_at = -10

func _ready():
	init()
	
func init():
	self.cur_health = self.max_health - 5
	emit_signal("health_changed", self.cur_health)

func hurt(damage: int, _dir: Vector3):
	if self.cur_health <= 0:
		return
	
	self.cur_health -= damage
	
	if self.cur_health <= self.gib_at:
		pass  # TODO: Make gibs spawner
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
	
	print(self.cur_health)


func get_pickup(pickup_type, value):
	match pickup_type:
		Pickup.PICKUP_TYPES.HEALTH:
			heal(value)
