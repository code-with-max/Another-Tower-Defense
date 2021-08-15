extends Node2D


onready var level = get_parent()
onready var enemy_path = get_parent().get_node("Enemy_path")
onready var enemy_label = get_parent().get_node("UI/CR/Waves_label")
# get_tree().get_root().get_node("Node name")

var label_text = "Mobs left: %s"

export var enemies_in_level = 10
var enemy_counter = 0

var Enemies = [
	preload("res://enemies/Enemy_00.tscn"),
	preload("res://enemies/Enemy_01.tscn"),
	]


# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_label.set_text(label_text % str(enemies_in_level - enemy_counter))
	$Spawn_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func add_enemy():
	var enemy = level.random_choice(Enemies).instance()
	enemy_path.add_child(enemy)
	enemy.connect("iam_on_end", level, "_enemy_on_end")


func _on_Spawn_timer_timeout():
	if enemy_counter <= enemies_in_level:
		add_enemy()
		enemy_counter += 1
		enemy_label.set_text(label_text % str(enemies_in_level - enemy_counter))
		var time_delay = randi() % 6 + 5  # 5 6 7 8 9 10
		$Spawn_timer.start(time_delay)
