extends Node2D


var Enemies = [
	preload("res://enemies/Enemy_00.tscn"),
	preload("res://enemies/Enemy_01.tscn"),
	]


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func random_choice(array):
	array.shuffle()
	return array.front()


func add_enemy():
	var enemy = random_choice(Enemies).instance()
	$Enemy_path.add_child(enemy)


func _on_wave_timer_timeout():
	add_enemy()


