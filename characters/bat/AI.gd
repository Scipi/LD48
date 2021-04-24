extends Spatial


var goal_reached_distance = 0.1

onready var nav = get_parent().get_parent().get_node("Navigation")
onready var character_mover = get_parent().get_node("character_mover")
onready var goal = self.translation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dist_vec = goal - self.translation
	
	if dist_vec.length_squared() < self.goal_reached_distance:
		pass
