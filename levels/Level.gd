extends Node2D


var build_mode = false
var build_cells = []

onready var build_zone = $Build_zone
onready var build_menu = $UI/CR_build_menu
onready var game_menu = $UI/CR



var Turrets = {
	"IT": preload("res://turrets/Iron_turret.tscn"),
	"PL": preload("res://turrets/Plasma_turret.tscn"),
	}

var turret_for_build = null


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	build_cells = build_zone.get_used_cells()


func _unhandled_input(event):
	if build_mode: ## if true
		if event is InputEventScreenTouch and event.is_pressed():
			var clicked_cell = build_zone.world_to_map(event.get_position())
			if clicked_cell in build_cells:
#				if turret_for_build != null:
#					pass
				var turret = Turrets[turret_for_build].instance()
				turret.set_position(build_zone.map_to_world(clicked_cell) + Vector2(64, 64))
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


func _enemy_on_end():
	print("Base attacked!")


func _on_Build_mode_button_pressed():
	switch_build_mode()


func switch_build_mode():
	if build_mode: ## if true
		build_zone.hide()
		build_mode = false
		build_menu.set_visible(false)
		game_menu.set_visible(true)
	else: ## if false
#		build_zone.show()
		build_mode = true
		build_menu.set_visible(true)
		game_menu.set_visible(false)


func _on_IT_build_pressed():
	turret_for_build = "IT"
	build_zone.show()


func _on_PL_build_pressed():
	turret_for_build = "PL"
	build_zone.show()



func _restore_cell_for_build(arg):
	var restore_cell = build_zone.world_to_map(arg)
	build_zone.set_cell(restore_cell.x, restore_cell.y, 0)


func _on_Exit_button_t_pressed():
	GM.goto_scene(GM.levels["game_menu"])
