extends Node2D


var build_mode = false
var build_cells = []

onready var build_zone = $Build_zone

var Enemies = [
	preload("res://enemies/Enemy_00.tscn"),
	preload("res://enemies/Enemy_01.tscn"),
	]

var Turrets = [
	preload("res://turrets/Iron_turret.tscn"),
	preload("res://turrets/Plasma_turret.tscn"),
]




# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	add_enemy() # Delete after debug
	build_cells = build_zone.get_used_cells()
#	print(build_cells)


func _unhandled_input(event):
	if build_mode: ## if true
		if event is InputEventScreenTouch and event.is_pressed():
#			print("Pressed: " + str(event.get_position()))
			var clicked_cell = build_zone.world_to_map(event.get_position())
#			print(clicked_cell)
			if clicked_cell in build_cells:
				var turret = random_choice(Turrets).instance()
				turret.set_position(build_zone.map_to_world(clicked_cell) + Vector2(32, 32))
				build_zone.set_cell(clicked_cell.x, clicked_cell.y, -1)
				add_child(turret)
				turret.connect("turret_is_sell", self, "_restore_cell_for_build")
				switch_build_mode()
			else:
				switch_build_mode()


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


func _on_Build_mode_button_pressed():
	switch_build_mode()


func switch_build_mode():
	if build_mode: ## if true
		build_zone.hide()
		build_mode = false
	else: ## if false
		build_zone.show()
		build_mode = true
#	print("Build mode is: " + str(build_mode))
	
	
func _restore_cell_for_build(arg):
#	print("Sell signal is emitted")
#	print(str(arg))
	var restore_cell = build_zone.world_to_map(arg)
#	print(restore_cell)
	build_zone.set_cell(restore_cell.x, restore_cell.y, 0)
