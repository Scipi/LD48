extends Node
class_name Run

var rng = RandomNumberGenerator.new()
var run_dat = {run_seed=null,lvls=[],data={spawn_mult=1,health_mult=1,armor_mult=1,damage_mult=1,level_mult=1,spawn_dec=0}}

var cur_run = "user://run.save"

func _init(mult,dec,hmult,dmult,amult,lmult):
	run_dat.data[0] = mult or 1
	run_dat.data[5] = dec or 0
	run_dat.data[1] = hmult or 1
	run_dat.data[3] = dmult or 1
	run_dat.data[2] = amult or 1
	run_dat.data[4] = lmult or 1


func _ready():
	#load_from_file()
	if !run_dat.run_seed:
		rng.randomize()
		run_dat.run_seed = rng.get_seed()
	
	for i in range(0,10):
		if i == 0:
			#lvls[i] = Town.new()
			pass
		else:
			run_dat.lvls[i] = Dungeon_Floor.new(i)


#func save_to_file():
#	var file = File.new()
#	file.open(cur_run, File.WRITE)
#	file.store_var(run_dat, true)
#	file.close()
#
#
#func load_from_file():
#	var file = File.new()
#	if file.file_exists(cur_run):
#		file.open(cur_run, File.READ)
#		run_dat = file.get_var(true)
#		file.close()
