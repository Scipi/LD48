extends Spatial

var hit_effect = preload("res://misc/hit_effect.tscn")

export var distance = 1000
var bodies_to_exclude = []
var damage = 1

func set_damage(_damage):
	self.damage = _damage

func set_bodies_to_exclude(_bodies_to_exclude):
	self.bodies_to_exclude = _bodies_to_exclude
	
func attack():
	var space_state = get_world().get_direct_space_state()
	var our_pos = self.global_transform.origin
	var result = space_state.intersect_ray(
		our_pos,
		our_pos - self.global_transform.basis.z * self.distance,
		self.bodies_to_exclude,
		1 + 2 + 4, true, true
	)
	
	if result and result.collider.has_method("hurt"):
		print("hurt")
		result.collider.hurt(self.damage, result.normal)
	elif result:
		var hit_effect_inst = self.hit_effect.instance()
		get_tree().get_root().add_child(hit_effect_inst)
		hit_effect_inst.global_transform.origin = result.position
		
		if result.normal.angle_to(Vector3.UP) < 0.00005:
			return
		if result.normal.angle_to(Vector3.DOWN) < 0.00005:
			hit_effect_inst.rotate(Vector3.RIGHT, PI)
			return
		
		var y = result.normal
		var x = y.cross(Vector3.UP)
		var z = x.cross(y)
		
		hit_effect_inst.global_transform.basis = Basis(x, y, z)
		
