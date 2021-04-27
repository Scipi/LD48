extends Spatial

var rng = RandomNumberGenerator.new()

var tavern = preload("res://levels/tavern.tscn")

var levels = [
	preload("res://levels/Level_1.tscn"),
	preload("res://levels/Level_2.tscn"),
	preload("res://levels/Level_3.tscn"),
	preload("res://levels/Level_1.tscn"),
	preload("res://levels/Level_2.tscn"),
	preload("res://levels/Level_3.tscn"),
	preload("res://levels/Level_1.tscn"),
	preload("res://levels/Level_2.tscn"),
	preload("res://levels/Level_3.tscn"),
	preload("res://levels/Level_2.tscn"),
]

var artifacts = [
	[preload("res://pickups/artifacts/artifact_1.tscn"), 0],
	[preload("res://pickups/artifacts/artifact_2.tscn"), 1],
	[preload("res://pickups/artifacts/artifact_3.tscn"), 2],
	[preload("res://pickups/artifacts/artifact_4.tscn"), 3],
	[preload("res://pickups/artifacts/artifact_5.tscn"), 4],
	[preload("res://pickups/artifacts/artifact_6.tscn"), 5],
	[preload("res://pickups/artifacts/artifact_7.tscn"), 6],
	[preload("res://pickups/artifacts/artifact_8.tscn"), 7],
	[preload("res://pickups/artifacts/artifact_9.tscn"), 8],
	[preload("res://pickups/artifacts/artifact_10.tscn"), 9],
]

var current_level = null
var level_index = -1
var day = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	rng.randomize()
	self.levels.shuffle()
	self.artifacts.shuffle()
	
	# instantiate_level(level_index, false)
	var t = tavern.instance()
	add_child(t)
	t.init(day, len($relic_manager.claimed_relics))
	current_level = t

func instantiate_level(level_index, ascent):
	
	if ascent:
		play_music("cave_gtfo")
	else:
		if day < 3:
			play_music("cave_day_1")
		elif day < 5:
			play_music("cave_day_3")
		elif day < 8:
			play_music("cave_day_5")
		elif day < 10:
			play_music("cave_day_8")
		else:
			play_music("cave_day_10")
	
	var p = get_tree().get_nodes_in_group("player").front()
	if p:
		p.get_parent().remove_child(p)
	current_level.queue_free()
	print(level_index)
	var level = levels[level_index]
	var artifact = artifacts[level_index][0]
	var artifact_id = artifacts[level_index][1]
	var l = level.instance()
	var a = artifact.instance()
	
	add_child(l)
	l.init(rng, ascent, a, day)
	
	if artifact_id in $relic_manager.claimed_relics:
		a.hide()
	
	current_level = l

func ascend():
	level_index -= 1
	if level_index < 0:
		$CanvasLayer/gui.hide()
		stop_all_music()
		day += 1
		current_level.queue_free()
		var t = tavern.instance()
		add_child(t)
		t.init(day, len($relic_manager.claimed_relics))
		current_level = t
		return
		
	instantiate_level(level_index, true)

func descend():
	$CanvasLayer/gui.show()
	level_index += 1
	if level_index >= len(levels):
		level_index = len(levels)-1
		return
	
	instantiate_level(level_index, false)

func stop_all_music():
	for m in $music_anim.get_children():
		m.playing = false

func play_music(track):
	if not $music_anim.get_node(track).playing:
		stop_all_music()
		$music_anim.get_node(track).playing = true
		$music_anim.get_node(track).volume_db = -10
		$music_anim/ambiance.playing = true
