extends KinematicBody

var hotkeys = {
	KEY_1: 0,
	KEY_2: 1,
	KEY_3: 2,
	KEY_4: 3,
	KEY_5: 4,
	KEY_6: 5,
	KEY_7: 6,
	KEY_8: 7,
	KEY_9: 8,
	KEY_0: 9,
}

export var mouse_sens = 0.15

var dead = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$character_mover.init(self)
	$pickup_manager.max_player_health = $health_manager.max_health
	$pickup_manager.connect("got_pickup", $Camera/weapon_manager, "get_pickup")
	$pickup_manager.connect("got_pickup", $health_manager, "get_pickup")
	$health_manager.connect("health_changed", $pickup_manager, "update_player_health")
	$health_manager.init()
	$health_manager.connect("dead", self, 'kill')
	$Camera/weapon_manager.init($Camera/fire_point, [self])
	

func _process(_delta):
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
	
	$Camera/weapon_manager.attack(
		Input.is_action_just_pressed("attack"),
		Input.is_action_pressed("attack")
	)

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
		
		if event.pressed and event.scancode in self.hotkeys:
			$Camera/weapon_manager.switch_weapon(self.hotkeys[event.scancode])
	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			$Camera/weapon_manager.prev_weapon()
		if event.button_index == BUTTON_WHEEL_DOWN:
			$Camera/weapon_manager.next_weapon()
		

func hurt(damage, dir):
	$health_manager.hurt(damage, dir)

func heal(amount):
	$health_manager.heal(amount)

func kill():
	self.dead = true
	$character_mover.freeze()

