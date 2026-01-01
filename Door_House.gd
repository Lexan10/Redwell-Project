extends Area2D

class_name Door_House

export var destination_level_tag: String
export var destination_door_tag: String
export var spawn_direction = "up"

export (Resource) var dialogue_resource
export (String) var dialogue_start_node := "texthouse1"

export(Resource) var dialogue_return_resource
export(String) var dialogue_return_start := "return_start"
export(String) var minigame_flag := "clock_house1_done"

onready var spawn = $Spawn
onready var warning = get_node_or_null("Warning")

var player_inside := false
var busy := false
var player_ref: Node = null

func _ready():
	if warning:
		warning.visible = false

func _process(_dt):
	if busy:
		return
	
	if player_inside and Input.is_action_just_pressed("interact"):
		busy = true
		if warning:
			warning.visible = false
		if player_ref:
			player_ref.can_move = false
		if Notes.has_flag(minigame_flag):
			DialogueAutoload.return_yes = false
			DialogueManager.show_example_dialogue_balloon(dialogue_return_start, dialogue_return_resource)
			yield(DialogueManager, "dialogue_finished")
			if player_ref:
				player_ref.can_move = true
			if DialogueAutoload.return_yes:
				NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
		
		else:
			DialogueAutoload.selected_companion = ""
			DialogueManager.show_example_dialogue_balloon(dialogue_start_node, dialogue_resource)
			yield(DialogueManager, "dialogue_finished")
			if player_ref:
				player_ref.can_move = true
			if DialogueAutoload.selected_companion != "":
				NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
		busy = false
		if player_inside and warning:
			warning.visible = true

func _on_Door_House_body_entered(body):
	if body is Player:
		player_inside = true
		player_ref = body
		if warning:
			warning.visible = true

func _on_Door_House_body_exited(body):
	if body is Player:
		player_inside = false
		player_ref = null
		if warning:
			warning.visible = false
