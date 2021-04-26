extends Label


var stat = 0
func update_stat(amnt):
	self.stat = amnt
	update_display()


func update_display():
	var stat_amnt = str(stat)
	if stat < 0:
		stat_amnt = "-"
	self.text = stat_amnt
