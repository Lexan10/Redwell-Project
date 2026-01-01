extends Control

export(float) var char_interval := 0.1

onready var text_label: Label = $Text
onready var timer: Timer = $Timer
onready var btn: Button = $Button
onready var sfx_players = [$TypeSfx1, $TypeSfx2, $TypeSfx3]
var _sfx_i := 0

var pages = [
	"Anglaterra.\nFinals dels anys 80.\n\nHi ha llocs que el temps sembla haver oblidat.\nPobles on el silenci pesa mes que les paraules.",
	"Em dic Hunter.\n\nAbans era inspector de policia.\nAra investigo els casos mes estranys, els paranormals.\nEls que no surten als informes oficials.",
	"Fa setmanes que arriben informes \ndel poble remot: Redwell.\n\nDesaparicions.\nCriatures de novel.les de terror.\nI un rellotge… aturat sempre a la mateixa hora.\n\nAquesta nit, hi vaig.",
	"Per moure't, utilitza les fletxes o AWSD. \nPer interactuar amb gent i objectes, clica la E. \nPer sortir, clica ESC \n\nSort."
]
var page_index := 0
var char_index := 0
var full_text := ""
var typing := false

func _ready():
	if not BgMusic.playing:
		BgMusic.play()
	text_label.text = ""
	btn.visible = false
	timer.wait_time = char_interval
# warning-ignore:return_value_discarded
	timer.connect("timeout", self, "_on_Timer_timeout")
# warning-ignore:return_value_discarded
	btn.connect("pressed", self, "_on_Button_pressed")
	_start_page(0)

func _start_page(index: int) -> void:
	page_index = index
	full_text = pages[page_index]
	char_index = 0
	typing = true
	text_label.text = ""
	btn.visible = false
	timer.start()

func _on_Timer_timeout() -> void:
	if char_index >= full_text.length():
		timer.stop()
		typing = false
		btn.visible = true
		if page_index == pages.size() - 1:
			btn.text = "Iniciar"
		else:
			btn.text = "Continuar"
		return

	text_label.text += full_text[char_index]
	char_index += 1
	var c = full_text[char_index - 1]
	if c != " " and c != "\n":
		_play_type_sfx()

func _play_type_sfx():
	var p: AudioStreamPlayer = sfx_players[_sfx_i]
	_sfx_i = (_sfx_i + 1) % sfx_players.size()
	p.stop()
	p.play()

func _on_Button_pressed() -> void:
	if typing:
		timer.stop()
		typing = false
		text_label.text = full_text
		btn.visible = true
		return
	if page_index < pages.size() - 1:
		_start_page(page_index + 1)
	else:
		TransitionScreen.transition()
		yield(TransitionScreen, "on_transition_finished")
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Ruta1.tscn")

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") \
	or (event is InputEventMouseButton and event.pressed):
		_on_Button_pressed()
