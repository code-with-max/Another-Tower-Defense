extends Node2D


enum states {
	IDLE,
	ATTACK,
}

enum Attack_type {
	IRON,
	PLASMA,
}

signal turret_is_sell(sell_position)

var current_state = states.IDLE
var upgrade_level = 0

# must make setget methods!
export var attack_force : float 
export (Attack_type) var attack_type
export var reload_time : float
export (Array, Resource) var animation_sprites
export var frame_for_shoot : int

var loaded = true
onready var reload_timer = $Reloading_timer

var watching_enemies = []


# Called when the node enters the scene tree for the first time.
func _ready():
	set_upg_level_animation(upgrade_level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	match current_state:
		
		states.IDLE:
			if watching_enemies.size() > 0:
				current_state = states.ATTACK
		
		states.ATTACK:
			if watching_enemies.size() > 0:
				$Turret_gun.look_at(watching_enemies[0].get_global_position())
				if loaded:
					$Turret_gun/Animation.play("shoot")
					if $Turret_gun/Animation.get_frame() == frame_for_shoot:
						# !!! Need check is current target is walid
						shoot(watching_enemies[0])
			else:
				current_state = states.IDLE


func shoot(attack_obj):
	if attack_obj != null:
		attack_obj.take_damage(attack_force)
	loaded = false
	reload_timer.start(reload_time)
	# Debug
	print(str(attack_type) + " - " + str(frame_for_shoot)) 


func set_upg_level_animation(c_l):
	$Turret_gun/Animation.set_sprite_frames(animation_sprites[c_l])


func _on_Watch_radius_area_entered(area):
	if area.get_parent().has_method("take_damage"):
		watching_enemies.append(area.get_parent())


func _on_Watch_radius_area_exited(area):
	watching_enemies.erase(area.get_parent())


func _on_Reloading_timer_timeout():
	loaded = true


func _on_Animation_animation_finished():
	$Turret_gun/Animation.stop()
	$Turret_gun/Animation.set_frame(0)


func _on_Upg_menu_button_pressed():
	$Upgrade_menu.show()


func hide_upgade_menu():
	$Upgrade_menu.hide()
