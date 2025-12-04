extends Node

const scene_ruta1 = preload("res://Ruta1.tscn")
const scene_town = preload("res://Town.tscn")
const scene_ruta2 = preload("res://Ruta2.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	if level_tag == "ruta1":
		scene_to_load = scene_ruta1
	elif level_tag == "town":
		scene_to_load = scene_town
	elif level_tag == "ruta2":
		scene_to_load = scene_ruta2
	
	
	if scene_to_load != null:
		TransitionScreen.transition()
		yield(TransitionScreen, "on_transition_finished")
		spawn_door_tag = destination_tag
# warning-ignore:return_value_discarded
		get_tree().change_scene_to(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	emit_signal("on_trigger_player_spawn", position, direction)
