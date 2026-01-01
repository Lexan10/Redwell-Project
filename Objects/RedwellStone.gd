extends StaticBody2D

onready var warning := $Warning

var resource := preload("res://dialogues/dialogue_stone_town.tres")
var player_inside := false

func _process(_dt):
	if player_inside and Input.is_action_just_pressed("interact"):
		_start_dialog()

func _start_dialog():
	DialogueManager.show_example_dialogue_balloon("textstonetown", resource)

func _on_Area2D_body_entered(body):
	if body is Player:
		player_inside = true
		if warning: warning.visible = true

func _on_Area2D_body_exited(body):
	if body is Player:
		player_inside = false
		if warning: warning.visible = false
