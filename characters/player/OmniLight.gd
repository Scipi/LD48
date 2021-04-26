extends OmniLight


onready var relic_manager = get_tree().get_nodes_in_group("relic_manager")[0]

onready var starting_light_energy = light_energy
onready var starting_light_range = omni_range

func _process(delta):
	if relic_manager.active_relics[9]:
		light_energy = starting_light_energy / 4
		omni_range = starting_light_range / 2
	else:
		light_energy = starting_light_energy
		omni_range = starting_light_range
