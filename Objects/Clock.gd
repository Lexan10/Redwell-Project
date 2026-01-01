extends StaticBody2D

export(NodePath) var minigame_path
export(NodePath) var informe_path
onready var minigame = get_node(minigame_path)
onready var warning := $Warning
onready var informe = get_node(informe_path)
var player_inside := false
var busy := false
var player_ref = null
var completed := false

func _ready():
	if warning:
		warning.visible = false

func set_completed(v: bool) -> void:
	completed = v
	if warning:
		warning.visible = false

func _process(_dt):
	if completed:
		return
	if busy:
		return

	if player_inside and Input.is_action_just_pressed("interact"):
		busy = true
		_open_minigame()

func _open_minigame():
	if not minigame:
		busy = false
		return
	if player_ref:
		player_ref.can_move = false
	minigame.start()

	if not minigame.is_connected("solved", self, "_on_minigame_solved"):
		minigame.connect("solved", self, "_on_minigame_solved", [], CONNECT_ONESHOT)

	if not minigame.is_connected("cancelled", self, "_on_minigame_cancelled"):
		minigame.connect("cancelled", self, "_on_minigame_cancelled", [], CONNECT_ONESHOT)

func _on_minigame_cancelled():
	if player_ref:
		player_ref.can_move = true
	busy = false

func _on_minigame_solved():
	if player_ref:
		player_ref.can_move = true
	busy = false
	completed = true
	if informe:
		informe.activate()

	if warning:
		warning.visible = false
	set_process(false)

func _on_Area2D_body_entered(body):
	if completed:
		return
	if body is Player:
		player_inside = true
		player_ref = body
		if warning:
			warning.visible = true

func _on_Area2D_body_exited(body):
	if body is Player:
		player_inside = false
		player_ref = null
		if warning:
			warning.visible = false
