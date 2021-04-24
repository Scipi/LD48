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
	
	var goal = Vector3(0,2,0)#nav.get_closest_point(Vector3(0,2,0))
	
	if player:
		goal = player.translation
		print(goal)
	var senses = get_parent().get_node("Senses")
	var position = get_parent_spatial().to_global(self.translation)
	var weight = 1
	var move_vec = Vector3.FORWARD*2
	if senses.get_node("Forward").is_colliding():
		weight = 0.3
	var dir = get_parent_spatial().to_local((goal-position).normalized())
	dir.z = 0
	dir.y = 0
	move_vec = Vector3.FORWARD+dir
	move_vec += Vector3(rng.randf_range(-1,1),0,0)

	#if senses.get_node("Right").is_colliding():
	#	move_vec +=Vector3.LEFT
	#if senses.get_node("Left").is_colliding():
	#	move_vec +=Vector3.RIGHT
	#if senses.get_node("Up").is_colliding():
	#	move_vec +=Vector3.DOWN
	#if senses.get_node("Down").is_colliding():
	#	move_vec +=Vector3.UP

	#print(move_vec)
	get_parent().look_at(move_vec,Vector3.UP)
	character_mover.set_move_vec(move_vec)
