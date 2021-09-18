extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Exit_button_pressed():
	GM.goto_scene(GM.levels["main_menu"])


func _on_Level_01_btn_pressed():
	GM.goto_scene(GM.levels["level01"])


func _on_Level_02_btn_pressed():
	GM.goto_scene(GM.levels["level02"])


func _on_Level_03_btn_pressed():
	GM.goto_scene(GM.levels["level03"])
