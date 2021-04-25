extends Area


signal got_pickup

onready var max_player_health = get_parent().get_node("health_manager").max_health
onready var cur_player_health = get_parent().get_node("health_manager").cur_health

func update_player_health(amnt):
	self.cur_player_health = amnt

func _ready():
	connect("area_entered", self, "on_area_enter")
	
func on_area_enter(pickup: Pickup):
	if pickup.pickup_type == pickup.PICKUP_TYPES.HEALTH and self.cur_player_health == self.max_player_health:
		return
	emit_signal("got_pickup", pickup.pickup_type, pickup.pickup_value)
	pickup.queue_free()
