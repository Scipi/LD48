extends Spatial


var goal_reached_distance = 0.1
onready var rng = RandomNumberGenerator.new()
onready var nav = get_parent().get_parent().get_node("Navigation")
onready var character_mover = get_parent().get_node("character_mover")
onready var goal = self.translation
onready var player = get_parent().get_parent().get_node("player")

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	character_mover.move_accel = 1
	character_mover.max_speed = 2
	character_mover.flying = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var senses = get_parent().get_node("Senses")
	
	var goal = Vector3(0,2,0)#nav.get_closest_point(Vector3(0,2,0))
	if player:
		goal = player.get_global_transform().origin+Vector3.UP*3*rng.randf_range(-2.5,5)
	
	var cur_trans = self.get_parent_spatial().get_global_transform()
	var final_trans = cur_trans.looking_at(goal,Vector3.UP)
	var look_trans = self.get_parent_spatial().get_global_transform().interpolate_with(final_trans,delta*rng.randf_range(-4,6))
	self.get_parent_spatial().set_global_transform(look_trans)
	
	#Bat does not fly up or down, not sure.
	var move_vec =Vector3(0,-look_trans.basis.z.y,-look_trans.basis.z.length())

	character_mover.set_move_vec(move_vec)
