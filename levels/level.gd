extends Spatial


var player = preload("res://characters/player/player.tscn")

var descent_enemies = [
	preload("res://characters/enemies/lesser_golem.tscn"),
	preload("res://characters/enemies/triskelemite.tscn")
]

var ascent_enemies = [
	preload("res://characters/enemies/lesser_golem.tscn"),
	preload("res://characters/enemies/tentacle.tscn"),
	preload("res://characters/enemies/triskelemite.tscn")
]

onready var relic_manager = get_tree().get_nodes_in_group("relic_manager")[0]

func init(rng: RandomNumberGenerator, is_ascent, relic, day):
	var player_group = get_tree().get_nodes_in_group("player")
	var p = player_group.front()
	
	if not p:
		p = player.instance()
	
	add_child(p)
	
	if is_ascent:
		p.global_transform = $player_spawn_ascent.global_transform
	else:
		p.global_transform = $player_spawn.global_transform
	
	for s in $descent_spawns.get_children():
		var i = rng.randi_range(0, len(descent_enemies)-1)
		var e = descent_enemies[i].instance()
		
		$Navigation.add_child(e)
		e.global_transform = s.global_transform
	
	if is_ascent:
		for s in $ascent_spawns.get_children():
			var i = rng.randi_range(0, len(ascent_enemies)-1)
			var e = ascent_enemies[i].instance()
			
			$Navigation.add_child(e)
			e.global_transform = s.global_transform
	
	if relic_manager.active_relics[5] and is_ascent:
		for s in $extra_swawns.get_children():
			var i = rng.randi_range(0, len(ascent_enemies)-1)
			var e = ascent_enemies[i].instance()
			
			$Navigation.add_child(e)
			e.global_transform = s.global_transform
	
	add_child(relic)
	relic.global_transform = $artifact_spawn.global_transform
