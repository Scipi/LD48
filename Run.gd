extends Node
class_name Run

var rng = RandomNumberGenerator.new()
var run_dat = {run_seed=0,lvls=[],data=[1,1,1,1,1,0]}
#data = 0:Spawn, 1:Health, 2:Armor, 3:Damage, 4:Level, 5:spawn decrease

var cur_run = "user://run.save"

func _init(mult,dec,hmult,dmult,amult,lmult):
	run_dat.data[0] = mult or 1
	run_dat.data[5] = dec or 0
	run_dat.data[1] = hmult or 1
	run_dat.data[3] = dmult or 1
	run_dat.data[2] = amult or 1
	run_dat.data[4] = lmult or 1


func _ready():
	load_from_file()
	rng.randomize()
	var run_Seed = rng.get_seed()
	
	for i in range(0,10):
		if i == 0:
			#lvls[i] = Town.new()
			pass
		else:
			run_dat.lvls[i] = Dungeon_Floor.new(i)

func save_to_file(cur_seed:int):
	var file = File.new()
	file.open(cur_run, File.WRITE)
	file.store_var(run_dat, true)
	file.close()


func load_from_file():
	var file = File.new()
	if file.file_exists(score_file):
		file.open(cur_run, File.READ)
		run_dat = file.get_var(true)
		file.close()
