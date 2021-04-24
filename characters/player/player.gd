extends KinematicBody


export var mouse_sens = 0.15

var dead = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$character_mover.init(self)
	$health_manager.init()
	$health_manager.connect("dead", self, 'kill')
	

func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
		
	if dead:
		return
	
	var move_vec = Vector3()
	if Input.is_action_pressed("move_forwards"):
		move_vec += Vector3.FORWARD
	
	if Input.is_action_pressed("move_backwards"):
		move_vec += Vector3.BACK
	
	if Input.is_action_pressed("move_left"):
		move_vec += Vector3.LEFT
	
	if Input.is_action_pressed("move_right"):
		move_vec += Vector3.RIGHT

	$character_mover.set_move_vec(move_vec)
	if Input.is_action_just_pressed("jump"):
		$character_mover.jump()

func _input(event):
	if event is InputEventMouseMotion:
		self.rotation_degrees.y -= self.mouse_sens * event.relative.x
		$Camera.rotation_degrees.x -= self.mouse_sens * event.relative.y
		$Camera.rotation_degrees.x = clamp(
			$Camera.rotation_degrees.x,
			-90,
			90
		)
	
	if event is InputEventKey:
		if event.is_action_pressed("quit"):
			self.get_tree().quit(0)

func hurt(damage, dir):
	$health_manager.hurt(damage, dir)

func heal(amount):
	$health_manager.heal(amount)

func kill():
	self.dead = true
	$character_mover.freeze()

