extends Area


var bodies_to_exclude = []
export var damage = 1

onready var relic_manager = get_tree().get_nodes_in_group("relic_manager")[0]

func set_damage(_damage: int):
	damage = _damage

func set_bodies_to_exclude(_bodies_to_exclude: Array):
	bodies_to_exclude = _bodies_to_exclude

func fire():
	for body in get_overlapping_bodies():
		if body.has_method("hurt") and !body in bodies_to_exclude:
			var damage_mult = 1.0
			if relic_manager.active_relics[1]:
				damage_mult = 2
			body.hurt(damage * damage_mult, global_transform.origin.direction_to(body.global_transform.origin))
