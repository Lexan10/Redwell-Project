extends CanvasLayer

onready var panel_main = $Panel2
onready var panel_confirm = $Panel3

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	visible = false
	panel_confirm.visible = false
	panel_main.visible = true

func _input(event):
	if event.is_action_pressed("ui_pause"):
		var scene_name = get_tree().get_current_scene().name
		if scene_name == "Main_Menu":
			return
		if get_tree().paused and panel_confirm.visible:
			_show_main_panel()
			return
		if get_tree().paused:
			toggle_pause()
			return
		if DialogueManager.is_dialogue_running:
			return
		toggle_pause()

func toggle_pause():
	var new_state = not get_tree().paused
	get_tree().paused = new_state
	visible = new_state
	if new_state:
		_show_main_panel()

func _show_main_panel():
	panel_main.visible = true
	panel_confirm.visible = false

func _show_confirm_panel():
	panel_main.visible = false
	panel_confirm.visible = true

func _on_resume_pressed():
	get_tree().paused = false
	visible = false

func _on_menu_pressed():
	_show_confirm_panel()

func _on_quit_pressed():
	get_tree().quit()

func _on_yes_pressed():
	get_tree().paused = false
	visible = false
	TransitionScreen.transition()
	yield(TransitionScreen, "on_transition_finished")
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Main_Menu.tscn")

func _on_no_pressed():
	_show_main_panel()
