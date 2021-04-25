extends Spatial

var goal_reached_distance = 0.1
onready var rng = RandomNumberGenerator.new()
onready var nav = get_parent().get_parent().get_node("Navigation")
onready var character_mover = get_parent().get_node("character_mover")
onready var spatial_parent = get_parent_spatial()
onready var State = "IDLE"
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	character_mover.move_accel = 1
	character_mover.max_speed = 2
	character_mover.flying = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match State:
		"IDLE":
			self.get_node("Idle").perform(delta)
		_:
			print("No such state "+State)
