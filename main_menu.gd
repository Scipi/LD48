extends Node2D

var start = preload("res://levels/level_manager.tscn")
var credits = preload("res://credits.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _input(event):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event.is_action_pressed("quit"):
		confirm_exit()

func start():
	get_tree().change_scene_to(start)

func settings():
	pass

func credits():
	var c = credits.instance()
	$overlay_layer.add_child(c)

func confirm_exit():
	get_tree().quit()
