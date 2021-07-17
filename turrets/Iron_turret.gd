extends Node2D


enum states {
	IDLE,
	ATTACK,
}

var current_state = states.IDLE

var watching_enemies = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match current_state:
		
		states.IDLE:
			if watching_enemies.size() > 0:
				current_state = states.ATTACK
		
		states.ATTACK:
			if watching_enemies.size() > 0:
				$Turret_gun.look_at(watching_enemies[0].get_global_position())
				# Must shoot here
			else:
				current_state = states.IDLE


func _on_Watch_radius_area_entered(area):
	watching_enemies.append(area.get_parent())
	print("Watching enemies: " + str(watching_enemies.size()))


func _on_Watch_radius_area_exited(area):
	watching_enemies.erase(area.get_parent())
	print("Watching enemies: " + str(watching_enemies.size()))
