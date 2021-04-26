extends Area

class_name Pickup

enum PICKUP_TYPES {
	ARROW,
	GOLD,
	HEALTH,
	ARTIFACT_1,
	ARTIFACT_2,
	ARTIFACT_3,
	ARTIFACT_4,
	ARTIFACT_5,
	ARTIFACT_6,
	ARTIFACT_7,
	ARTIFACT_8,
	ARTIFACT_9,
	ARTIFACT_10,
}

export (PICKUP_TYPES) var pickup_type
export var pickup_value = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("spin")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
