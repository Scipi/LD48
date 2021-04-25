extends Spatial

var goal_reached_distance = 0.1
var goal = Vector3(0,2,0)
onready var jitter = 5 #How much randomness in flight
onready var turn_rate = 0.1 #Min turnrate

# Called every frame. 'delta' is the elapsed time since the previous frame.
func perform(delta):
	if get_parent().get_parent_spatial().get_global_transform().origin.distance_to(goal) < goal_reached_distance:
		goal = goal+Vector3(get_parent().rng.randf_range(-5,5),clamp(get_parent().rng.randf_range(-5,5),0,8),get_parent().rng.randf_range(-5,5))
	#if player:
	#	goal = get_parent().player.get_global_transform().origin+Vector3.UP*3*rng.randf_range(-2.5,5)
	
	#Set look direction math.
	var cur_trans = get_parent().get_parent_spatial().get_global_transform()
	var final_trans = cur_trans.looking_at(goal,Vector3.UP)
	var look_trans = get_parent().get_parent_spatial().get_global_transform().interpolate_with(final_trans,delta*get_parent().rng.randf_range(turn_rate,1))
	#Sets look direction
	get_parent().get_parent_spatial().set_global_transform(look_trans)
	
	#Bat does not fly up or down, not sure.
	var move_vec =Vector3(0,-look_trans.basis.z.y,-look_trans.basis.z.length())

	get_parent().character_mover.set_move_vec(move_vec+Vector3(get_parent().rng.randf_range(-1,1)*jitter,get_parent().rng.randf_range(-1,1)*jitter,get_parent().rng.randf_range(-0.1,0.1)*jitter))
