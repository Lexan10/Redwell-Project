extends CanvasLayer
signal closed

export(String, MULTILINE) var full_text := ""
export(float) var chars_per_sec := 40.0

onready var label := $Panel/Text
onready var btn := $Panel/BtnClose

var _t := 0.0
var _done := false

func _ready():
	label.bbcode_text = ""
# warning-ignore:return_value_discarded
	btn.connect("pressed", self, "_on_close_pressed")
	set_process(true)

func _process(delta):
	if _done:
		return

	_t += delta * chars_per_sec
	var n = int(_t)
	if n >= full_text.length():
		n = full_text.length()
		_done = true
	label.bbcode_text = full_text.substr(0, n)

func _on_close_pressed():
	emit_signal("closed")
	queue_free()
