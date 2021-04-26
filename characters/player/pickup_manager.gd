extends Area


signal got_pickup

onready var max_player_health = get_parent().get_node("health_manager").max_health
onready var cur_player_health = get_parent().get_node("health_manager").cur_health

onready var relic_manager = get_tree().get_nodes_in_group("relic_manager")[0]

func update_player_health(amnt):
	self.cur_player_health = amnt

func _ready():
	connect("area_entered", self, "on_area_enter")
	
func on_area_enter(pickup: Pickup):
	var max_player_health = get_parent().get_node("health_manager").max_health
	var cur_player_health = get_parent().get_node("health_manager").cur_health
	if pickup.pickup_type == pickup.PICKUP_TYPES.HEALTH and self.cur_player_health == self.max_player_health:
		return
	
	match pickup.pickup_type:
		Pickup.PICKUP_TYPES.ARTIFACT_1:
			relic_manager.claim_relic(0)
		Pickup.PICKUP_TYPES.ARTIFACT_2:
			relic_manager.claim_relic(1)
		Pickup.PICKUP_TYPES.ARTIFACT_3:
			relic_manager.claim_relic(2)
		Pickup.PICKUP_TYPES.ARTIFACT_4:
			relic_manager.claim_relic(3)
		Pickup.PICKUP_TYPES.ARTIFACT_5:
			relic_manager.claim_relic(4)
		Pickup.PICKUP_TYPES.ARTIFACT_6:
			relic_manager.claim_relic(5)
		Pickup.PICKUP_TYPES.ARTIFACT_7:
			relic_manager.claim_relic(6)
		Pickup.PICKUP_TYPES.ARTIFACT_8:
			relic_manager.claim_relic(7)
		Pickup.PICKUP_TYPES.ARTIFACT_9:
			relic_manager.claim_relic(8)
		Pickup.PICKUP_TYPES.ARTIFACT_10:
			relic_manager.claim_relic(9)
	
	emit_signal("got_pickup", pickup.pickup_type, pickup.pickup_value)
	pickup.queue_free()
