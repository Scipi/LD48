extends Spatial


func init(day, num_artifacts_collected):
	match day:
		1:
			$day_1.show()
			$day_1/syndibox.connect("text_finished", self, "return_to_caves")
		2:
			$day_2.show()
			$day_2/syndibox.connect("text_finished", self, "return_to_caves")
		3:
			$day_3.show()
			$day_3/syndibox.connect("text_finished", self, "return_to_caves")
		4:
			$day_4.show()
			$day_4/syndibox.connect("text_finished", self, "return_to_caves")
		5:
			$day_5.show()
			$day_5/syndibox.connect("text_finished", self, "return_to_caves")
		6:
			$day_6.show()
			$day_6/syndibox.connect("text_finished", self, "return_to_caves")
		7:
			$day_7.show()
			$day_7/syndibox.connect("text_finished", self, "return_to_caves")
		8:
			$day_8.show()
			$day_8/syndibox.connect("text_finished", self, "return_to_caves")
		9:
			$day_9.show()
			$day_9/syndibox.connect("text_finished", self, "return_to_caves")
		10:
			$day_10.show()
			$day_10/syndibox.connect("text_finished", self, "return_to_caves")
		

func return_to_caves():
	var lm = get_tree().get_nodes_in_group("level_manager")[0]
	lm.descend()
	print("descend")

func _ready():
	pass
