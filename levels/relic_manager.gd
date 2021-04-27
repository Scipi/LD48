extends Spatial


var active_relics = [
	false,  # less player damage
	false,  # more enemy damage
	false,  # faster enemies
	true,  # fewer pickups
	false,  # double ammo consumption
	true,  # extra enemy spawns
	false,  # no jumping
	false,  # larger fireball
	false,  # less max health
	false,  # darker cave
]

var claimed_relics = []

func claim_relic(relic_id):
	active_relics[relic_id] = true
	claimed_relics.append(relic_id)

func reset_active_relics():
	active_relics = [
		false,  # less player damage
		false,  # more enemy damage
		false,  # faster enemies
		true,  # fewer pickups
		false,  # double ammo consumption
		true,  # extra enemy spawns
		false,  # no jumping
		false,  # larger fireball
		false,  # less max health
		false,  # darker cave
	]
