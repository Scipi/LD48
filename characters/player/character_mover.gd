extends Spatial

var body_to_move : KinematicBody = null

export var move_accel = 4
export var max_speed = 25
var drag = 0.0
export var jump_force = 30
export var gravity = 100
export var flying = false

var pressed_jump = false
var move_vec : Vector3
var velocity : Vector3
var snap_vec : Vector3
export var ignore_rotation = false

signal movement_info

var frozen = false

func _ready():
	self.drag = float(self.move_accel) / self.max_speed
	

func init(_body_to_move: KinematicBody):
	body_to_move = _body_to_move


func jump():
	self.pressed_jump = true
	

func set_move_vec(_move_vec: Vector3):
	move_vec = _move_vec.normalized()
	

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


func freeze():
	self.frozen = true


func unfreeze():
	self.frozen = false
