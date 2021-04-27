extends Spatial

var body_to_move : KinematicBody = null
var debug = true

export var move_accel = 4
export var max_speed = 25
var drag = 0.0

export var jump_force = 30
export var gravity = 100
export var flying = false
export var enemy = false

var pressed_jump = false
var move_vec : Vector3
var velocity : Vector3
var snap_vec : Vector3
export var ignore_rotation = false

signal movement_info

var frozen = false

onready var relic_manager = get_tree().get_nodes_in_group("relic_manager")[0]

func _ready():
	self.drag = float(self.move_accel) / self.max_speed


func init(_body_to_move: KinematicBody):
	body_to_move = _body_to_move


func jump():
	if relic_manager.active_relics[6]:
		return
	self.pressed_jump = true


func set_move_vec(_move_vec: Vector3):
	move_vec = _move_vec.normalized()
	

func _process(delta):
	var speed_mult = 1.0
	if relic_manager.active_relics[2] and self.enemy:
		speed_mult = 1.5
	self.drag = float(self.move_accel) / self.max_speed / speed_mult

func _physics_process(delta):
	if self.frozen:
		return
	
	var cur_move_vec = self.move_vec
	if not self.ignore_rotation:
		cur_move_vec = cur_move_vec.rotated(
			Vector3.UP,
			self.body_to_move.rotation.y
		)
		
	var vel_drag = self.velocity * Vector3(self.drag, 0, self.drag)
	var grav_acc = self.gravity * Vector3.DOWN * delta
	
	if self.flying:
		grav_acc = Vector3.ZERO
	
	self.velocity += self.move_accel * cur_move_vec - vel_drag + grav_acc

	self.velocity = self.body_to_move.move_and_slide_with_snap(
		self.velocity,
		self.snap_vec,
		Vector3.UP
	)
	
	if self.velocity.length_squared() > 0.5:
		play_walking_sound()
	else:
		stop_walking_sound()

	var grounded = self.body_to_move.is_on_floor()
	
	if not self.flying:
	
		if grounded:
			self.velocity.y = -0.01
		
		if grounded and self.pressed_jump:
			self.velocity.y = self.jump_force
			self.snap_vec = Vector3.ZERO
		
		else:
			self.snap_vec = Vector3.DOWN
		
		self.pressed_jump = false
	emit_signal("movement_info", self.velocity, grounded)


func play_walking_sound():
	if not $walking_sound.playing:
		$walking_sound.play()

func stop_walking_sound():
	$walking_sound.stop()


func freeze():
	self.frozen = true


func unfreeze():
	self.frozen = false
