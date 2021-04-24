extends KinematicBody


var dead = false

func _ready():
	$character_mover.init(self)
	$health_manager.init()
	$health_manager.connect("dead", self, 'kill')

func hurt(damage, dir):
	$health_manager.hurt(damage, dir)

func heal(amount):
	$health_manager.heal(amount)

func kill():
	self.dead = true
	$character_mover.freeze()
