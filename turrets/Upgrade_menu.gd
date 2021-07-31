extends Control

onready var turret = get_parent()
onready var upgrage_button = $ColorRect/Upg


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Upg_pressed():
	if turret.upgrade_level < 3:
		turret.upgrade_level += 1
		turret.set_upg_level_animation(turret.upgrade_level)
		turret.hide_upgade_menu()
	if turret.upgrade_level == 3:
		upgrage_button.hide()


func _on_Del_pressed():
	turret.queue_free()


func _on_Can_pressed():
	turret.hide_upgade_menu()
