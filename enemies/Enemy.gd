extends PathFollow2D

class_name Enemy


signal iam_on_end

enum states {
	MOVE, # 0
	ATTACK, # 1
	EXPLODE, # 2
}

var current_state = states.MOVE


enum avaible_armors {
	IRON, # 0
	PLASMA, # 1
	WOOD, # 2
}

export (avaible_armors) var armor setget ,get_armor
export var health : float setget set_health, get_health
export var speed : float setget set_speed, get_speed

onready var text_label = $unit_stats/VBox/Label3

# Called when the node enters the scene tree for the first time.
func _ready():
	$unit_stats/VBox/Label1.set_text(str(avaible_armors.keys()[armor]))
	$unit_stats/VBox/Label2.set_text("Speed: " + str(speed))
	$unit_stats/VBox/Label3.set_text("Health: " + str(health))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match current_state:
		states.MOVE:
			set_offset(get_offset() + speed * delta)
			if get_unit_offset() == 1:
				emit_signal("iam_on_end")
				current_state = states.EXPLODE
		states.ATTACK:
			pass
		states.EXPLODE:
			queue_free()


func take_damage(damage_val):
	set_health(get_health() - damage_val)
	# For some debug, delete from release
	text_label.set_text("Health: " + str(health))


# SET_GET Section
func get_armor():
	print("Armor getter its triggered")
	return armor


func set_health(new_val):
	health = clamp(new_val, 0, 200)
	if health == 0:
		current_state = states.EXPLODE


func get_health():
	return health


func set_speed(new_val):
	speed = clamp(new_val, 0, 200)


func get_speed():
	return speed
