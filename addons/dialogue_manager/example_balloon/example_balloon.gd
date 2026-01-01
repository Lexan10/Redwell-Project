extends CanvasLayer


signal actioned(next_id)


onready var balloon := $Balloon
onready var margin := $Balloon/Margin
onready var vbox := $Balloon/Margin/VBox
onready var character_label := $Balloon/Margin/VBox/Character
onready var dialogue_label := $Balloon/Margin/VBox/Dialogue
onready var responses_menu := $Balloon/Margin/VBox/Responses
onready var response_template := $ResponseTemplate

var dialogue_line: Dictionary
var is_waiting_for_input: bool = false

func _ready() -> void:
	if dialogue_line.size() == 0:
		queue_free()
		return

	response_template.hide()
	balloon.modulate.a = 0
	
	var viewport_size = balloon.get_viewport_rect().size
	balloon.anchor_right = 1
	balloon.rect_min_size = Vector2(viewport_size.x * 0.9, 0)
	balloon.rect_size = Vector2.ZERO
	
	var left_curr  = int(margin.get("custom_constants/margin_left"))
	var right_curr = int(margin.get("custom_constants/margin_right"))
	var top_curr   = int(margin.get("custom_constants/margin_top"))
	var bot_curr   = int(margin.get("custom_constants/margin_bottom"))

	var side = max(left_curr, right_curr)          # fem esquerra=dreta
	margin.set("custom_constants/margin_left", side)
	margin.set("custom_constants/margin_right", side)
	# assegura’t d’un top/bottom raonables
	if top_curr == 0:  top_curr = 14
	if bot_curr == 0:  bot_curr = 14
	margin.set("custom_constants/margin_top", top_curr)
	margin.set("custom_constants/margin_bottom", bot_curr)
	var content_width = balloon.rect_min_size.x - (side * 2)
	dialogue_label.rect_size.x = content_width
	
	vbox.set("custom_constants/separation", 4)
	
	character_label.visible = dialogue_line.character != ""
	character_label.bbcode_enabled = true
	character_label.bbcode_text = dialogue_line.character
	character_label.rect_min_size = Vector2(content_width, 18)
	character_label.add_constant_override("line_separation", -2)
	
	dialogue_label.dialogue_line = dialogue_line
	dialogue_label.fit_content_height = false
	dialogue_label.scroll_active = false
	dialogue_label.add_constant_override("line_separation", -2)
	dialogue_label.rect_clip_content = true
	
	yield(dialogue_label.reset_height(), "completed")
	
	# Show any responses we have
	if dialogue_line.responses.size() > 0:
		for response in dialogue_line.responses:
			# Duplicate the template so we can grab the fonts, sizing, etc
			var item: RichTextLabel = response_template.duplicate(0)
			item.name = "Response" + str(responses_menu.get_child_count())
			if not response.is_allowed:
				item.name += "Disallowed"
			item.bbcode_text = response.text
			item.connect("mouse_entered", self, "_on_response_mouse_entered", [item])
			item.connect("gui_input", self, "_on_response_gui_input", [item])
			item.show()
			responses_menu.add_child(item)
	
	# Make sure our responses get included in the height reset
	responses_menu.visible = true
	margin.rect_size = Vector2(0, 0)
	yield(get_tree(), "idle_frame")
	
	var max_h = float(viewport_size.y) * 0.25
	var desired_h = float(min(margin.rect_size.y, max_h))
	balloon.rect_min_size = Vector2(balloon.rect_min_size.x, desired_h)
	balloon.rect_size = Vector2.ZERO

# reparteix l'alçada útil perquè no desbordi per baix
	var usable_h = desired_h - float(top_curr) - float(bot_curr)
	var name_h = float(character_label.get_combined_minimum_size().y)

	var sep_val = vbox.get("custom_constants/separation")
	if sep_val == null:
		sep_val = 4
	var sep = float(sep_val)

	# Tenir en compte l'escala vertical del text:
	var scale_y = dialogue_label.rect_scale.y
# La 'rect_size.y' és abans d'escala; per cabre dins 'usable_h', dividim pel scale
	var target_drawn_h = max(0.0, usable_h - name_h - sep)
	dialogue_label.rect_size.y = target_drawn_h / max(0.001, scale_y)

# enganxada a baix amb petit marge i centrada
	var y_offset = float(viewport_size.y) * 0.03
	balloon.rect_global_position = Vector2(
	(viewport_size.x - balloon.rect_min_size.x) * 0.5,
	viewport_size.y - desired_h - y_offset
	)
	
	# Ok, we can hide it now. It will come back later if we have any responses
	responses_menu.visible = false
	
	# Show our box
	balloon.modulate.a = 1
	
	if dialogue_line.text != "":
		dialogue_label.type_out()
		yield(dialogue_label, "finished")
	
	# Wait for input
	if dialogue_line.responses.size() > 0:
		responses_menu.visible = true
		configure_focus()
	elif dialogue_line.time != null:
		var time = dialogue_line.text.length() * 0.02 if dialogue_line.time == "auto" else dialogue_line.time.to_float()
		yield(get_tree().create_timer(time), "timeout")
		next(dialogue_line.next_id)
	else:
		is_waiting_for_input = true
		balloon.focus_mode = Control.FOCUS_ALL
		balloon.grab_focus()


func _unhandled_input(event):
	if not is_waiting_for_input:
		return
	if event.is_action_pressed("ui_accept") \
		or event.is_action_pressed("ui_cancel") \
		or event.is_action_pressed("interact"):
		get_tree().set_input_as_handled()
		_close_balloon()


func next(next_id: String) -> void:
	emit_signal("actioned", next_id)
	queue_free()

### Helpers


func configure_focus() -> void:
	responses_menu.show()
	
	var items = get_responses()
	for i in items.size():
		var item: Control = items[i]
		
		item.focus_mode = Control.FOCUS_ALL
		
		item.focus_neighbour_left = item.get_path()
		item.focus_neighbour_right = item.get_path()
		
		if i == 0:
			item.focus_neighbour_top = item.get_path()
			item.focus_previous = item.get_path()
		else:
			item.focus_neighbour_top = items[i - 1].get_path()
			item.focus_previous = items[i - 1].get_path()
		
		if i == items.size() - 1:
			item.focus_neighbour_bottom = item.get_path()
			item.focus_next = item.get_path()
		else:
			item.focus_neighbour_bottom = items[i + 1].get_path()
			item.focus_next = items[i + 1].get_path()
	
	items[0].grab_focus()


func get_responses() -> Array:
	var items: Array = []
	for child in responses_menu.get_children():
		if "disallowed" in child.name.to_lower(): continue
		items.append(child)
		
	return items


### Signals


func _on_response_mouse_entered(item):
	if not "disallowed" in item.name.to_lower():
		item.grab_focus()


func _on_response_gui_input(event, item):
	if "disallowed" in item.name.to_lower(): return
	
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:
		next(dialogue_line.responses[item.get_index()].next_id)
	elif event.is_action_pressed("ui_accept") and item in get_responses():
		next(dialogue_line.responses[item.get_index()].next_id)


# When there are no response options the balloon itself is the clickable thing
func _on_Balloon_gui_input(event):
	if not is_waiting_for_input:
		return

	get_tree().set_input_as_handled()

	# Clic esquerre
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		_close_balloon()
	# Enter/Z, Esc o E
	elif event.is_action_pressed("ui_accept") \
		or event.is_action_pressed("ui_cancel") \
		or event.is_action_pressed("interact"):
		_close_balloon()

func _close_balloon() -> void:
	# Evita reobrir amb la mateixa pulsació
	Input.action_release("interact")
	Input.action_release("ui_accept")
	Input.action_release("ui_cancel")
	next(dialogue_line.next_id)
