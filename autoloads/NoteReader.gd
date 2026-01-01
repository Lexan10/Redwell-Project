extends Node

const NOTE_ID := "mutations_1"

const NOTE_UI_SCENE := preload("res://Objects/NoteUI.tscn")
const DLG_PICKUP := preload("res://dialogues/dlg_note_pickup.tres")
const DLG_PUTAWAY := preload("res://dialogues/dlg_note_putaway.tres")

var _reading := false
var busy := false
var player_ref: Node = null

func _ready():
	set_process(true)

func _process(_dt):
	if busy:
		return
	if Input.is_action_just_pressed("read_note_1"):
		busy = true
		if player_ref:
			player_ref.can_move = false
		var st = _try_open_note()
		if st:
			yield(st, "completed")
		if player_ref:
			player_ref.can_move = true
		busy = false
		print("PREMUT 1, Notes.has=", Notes.has("mutations_1"))

func _try_open_note():
	if _reading:
		return
	if not Notes.has(NOTE_ID):
		return

	_reading = true
	return _open_note_flow()

func _open_note_flow():
	yield(get_tree(), "idle_frame")

	# diàleg "agafa..."
	DialogueManager.show_example_dialogue_balloon("dlg_note_pickup", DLG_PICKUP)
	yield(DialogueManager, "dialogue_finished")

	# UI carta
	var ui = NOTE_UI_SCENE.instance()
	ui.full_text = Notes.get_text(NOTE_ID)
	get_tree().get_root().add_child(ui)
	yield(ui, "closed")

	# diàleg "guarda..."
	DialogueManager.show_example_dialogue_balloon("dlg_note_putaway", DLG_PUTAWAY)
	yield(DialogueManager, "dialogue_finished")
	_reading = false
