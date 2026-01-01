extends StaticBody2D

onready var anim := $AnimationPlayer
onready var warning := $Warning

export(Resource) var dialogue_resource
export(String) var dialogue_start_node = "start"

var player_dir := "" 
var player_inside := false
var busy := false
var player_ref: Node = null

func _process(_dt):
	if busy:
		return
	if player_inside and Input.is_action_just_pressed("interact"):
		busy = true
		if player_ref:
			player_ref.can_move = false
		DialogueManager.show_example_dialogue_balloon(dialogue_start_node, dialogue_resource)
		yield(DialogueManager, "dialogue_finished")
		if player_ref:
			player_ref.can_move = true
		busy = false
		if player_inside and warning:
			warning.visible = true

func _face_to_player_dir():
	match player_dir:
		"up":    anim.play("IdleUp")
		"down":  anim.play("IdleDown")
		"left":  anim.play("IdleLeft")
		"right": anim.play("IdleRight")
		_:
			anim.play("IdleDown")

func _on_AreaUp_body_entered(body):
	if body is Player:
		player_inside = true
		player_ref = body
		player_dir = "up"
		if warning: warning.visible = true

func _on_AreaUp_body_exited(body):
	if body is Player:
		player_inside = false
		player_ref = null
		if warning: warning.visible = false
		if player_dir == "up": player_dir = ""

func _on_AreaDown_body_entered(body):
	if body is Player:
		player_inside = true
		player_ref = body
		player_dir = "down"
		if warning: warning.visible = true

func _on_AreaDown_body_exited(body):
	if body is Player:
		player_inside = false
		player_ref = null
		if warning: warning.visible = false
		if player_dir == "down": player_dir = ""

func _on_AreaLeft_body_entered(body):
	if body is Player:
		player_inside = true
		player_ref = body
		player_dir = "right"
		if warning: warning.visible = true

func _on_AreaLeft_body_exited(body):
	if body is Player:
		player_inside = false
		player_ref = null
		if warning: warning.visible = false
		if player_dir == "right": player_dir = ""

func _on_AreaRight_body_entered(body):
	if body is Player:
		player_inside = true
		player_ref = body
		player_dir = "left"
		if warning: warning.visible = true

func _on_AreaRight_body_exited(body):
	if body is Player:
		player_inside = false
		player_ref = null
		if warning: warning.visible = false
		if player_dir == "left": player_dir = ""
