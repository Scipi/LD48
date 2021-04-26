extends Spatial


onready var relic_manager = get_tree().get_nodes_in_group("relic_manager")[0]

# Called when the node enters the scene tree for the first time.
func _ready():
	if relic_manager.active_relics[3]:
		hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
