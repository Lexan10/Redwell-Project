extends StaticBody2D

export(String) var note_id := "mutations_1"
export(PackedScene) var note_ui_scene

export(Resource) var dialogue_pickup
export(String) var pickup_start := "start"
export(Resource) var dialogue_putaway
export(String) var putaway_start := "start"

onready var warning := $Warning

var player_inside := false
var busy := false

func _ready():
	visible = false
	set_process(false)
	if warning:
		warning.visible = false

func activate():
	visible = true
	set_process(true)
	if warning:
		warning.visible = false

func _process(_dt):
	if busy:
		return
	if visible and player_inside and Input.is_action_just_pressed("interact"):
		busy = true
		var st = _open_note_flow()
		if st:
			yield(st, "completed")
		busy = false

func _open_note_flow():
	yield(get_tree(), "idle_frame")

	# diàleg "agafa..."
	if dialogue_pickup:
		DialogueManager.show_example_dialogue_balloon(pickup_start, dialogue_pickup)
		yield(DialogueManager, "dialogue_finished")

	# obre carta UI amb el text de Notes.gd
	if note_ui_scene:
		var ui = note_ui_scene.instance()
		if ui:
			ui.full_text = Notes.get_text(note_id)
			get_tree().get_root().add_child(ui)
			yield(ui, "closed")

	# diàleg "guarda..."
	if dialogue_putaway:
		DialogueManager.show_example_dialogue_balloon(putaway_start, dialogue_putaway)
		yield(DialogueManager, "dialogue_finished")

	# desbloqueja per sempre + amaga del terra
	Notes.add(note_id)
	if warning:
		warning.visible = false
	visible = false
	set_process(false)

func _on_Area2D_body_entered(body):
	if body is Player:
		player_inside = true
		if visible and warning:
			warning.visible = true

func _on_Area2D_body_exited(body):
	if body is Player:
		player_inside = false
		if warning:
			warning.visible = false
