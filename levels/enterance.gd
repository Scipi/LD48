extends Area

func _ready():
	self.connect("body_entered", self, "player_entered")
	self.connect("body_exited", self, "player_exited")

func player_entered(player):
	player.set_can_ascend(true)

func player_exited(player):
	player.set_can_ascend(false)
