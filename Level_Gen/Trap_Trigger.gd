extends MeshInstance



func _on_Area_body_entered(body):
	$GridMap.emit_signal("body_entered",body)
