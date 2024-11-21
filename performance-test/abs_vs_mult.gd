
extends Node

func _ready():
	print("Measuring the time it takes for Mult")
	var start := Time.get_ticks_usec()
	for i in randi_range(0, 10_000):
		by_mult()
	var end := Time.get_ticks_usec()
	var mult_time := (end-start)/1000000.0
	print("Multi time: %s\n" % [mult_time])

	print("Measuring the time it takes for Abs")
	start = Time.get_ticks_usec()
	for i in randi_range(0, 10_000):
		by_abs()
	end = Time.get_ticks_usec()
	var abs_time := (end-start)/1000000.0
	print("Abs time: %s\n" % [abs_time])


func by_mult()->int:
	var dir := randi_range(0, 1)*2-1
	return dir


func by_abs()->int:
	var dir := randi_range(-2, 1)
	if abs(dir) != dir: return -1
	else: return 1
	

