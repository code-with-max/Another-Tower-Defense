extends Node


# Declare member variables here. Examples:
var levels = {
	"main_menu": "res://main_menu.tscn",
	"game_menu": "res://game_menu.tscn",
	"level01": "res://levels/Level_01.tscn",
	"level02": "res://levels/Level_02.tscn",
	"level03": "res://levels/Level_03.tscn",
} 

var current_scene = null

onready var root = get_tree().get_root()


# Called when the node enters the scene tree for the first time.
func _ready():
	current_scene = root.get_child(root.get_child_count() - 1)
	print("Current scene is " + str(current_scene.name))


func goto_scene(path):
	call_deferred("_deffered_goto_scene", path)


func _deffered_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	root.add_child(current_scene)
	print("Current scene is " + str(current_scene.name))
