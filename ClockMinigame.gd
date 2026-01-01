extends CanvasLayer

signal solved
signal cancelled

export(float) var target_hour_deg := -46.2
export(float) var target_minute_deg := 90.0
export(float) var tolerance_deg := 3.0

export(float) var step_hour := 2.0
export(float) var step_minute := 2.0

export(float) var start_hour_deg := 0.0
export(float) var start_minute_deg := 0.0

onready var hour_pivot := $Panel/ClockRoot/HourPivot
onready var minute_pivot := $Panel/ClockRoot/MinutePivot
onready var target_hour_pivot := $Panel/ClockRoot/TargetHourPivot
onready var target_minute_pivot := $Panel/ClockRoot/TargetMinutePivot
onready var sfx := $Panel/SuccessSfx
onready var hint := $Panel/Hint
onready var hint_timer := $Panel/HintTimer

onready var btn_h_plus := $Panel/BtnHourPlus
onready var btn_h_minus := $Panel/BtnHourMinus
onready var btn_m_plus := $Panel/BtnMinPlus
onready var btn_m_minus := $Panel/BtnMinMinus
onready var btn_cancel := $Panel/BtnCancel

var _locked := false
var _completed := false

func _ready():
	visible = false
	target_hour_pivot.modulate.a = 0.4
	target_minute_pivot.modulate.a = 0.4
	target_hour_pivot.rotation_degrees = target_hour_deg
	target_minute_pivot.rotation_degrees = target_minute_deg
# warning-ignore:return_value_discarded
	btn_h_plus.connect("pressed", self, "_hour_plus")
# warning-ignore:return_value_discarded
	btn_h_minus.connect("pressed", self, "_hour_minus")
# warning-ignore:return_value_discarded
	btn_m_plus.connect("pressed", self, "_min_plus")
# warning-ignore:return_value_discarded
	btn_m_minus.connect("pressed", self, "_min_minus")

# warning-ignore:return_value_discarded
	hint_timer.connect("timeout", self, "_on_hint_timer_timeout")
# warning-ignore:return_value_discarded
	btn_cancel.connect("pressed", self, "_on_cancel_pressed")

func start():
	if _completed:
		return
	_locked = false
	visible = true
	hour_pivot.rotation_degrees = start_hour_deg
	minute_pivot.rotation_degrees = start_minute_deg
	btn_h_plus.disabled = false
	btn_h_minus.disabled = false
	btn_m_plus.disabled = false
	btn_m_minus.disabled = false
	target_hour_pivot.visible = true
	target_minute_pivot.visible = true
	hint.visible = false
	hint_timer.start(80)

func _on_cancel_pressed():
	if _locked:
		return
	hint.visible = false
	hint_timer.stop()
	visible = false
	emit_signal("cancelled")

func _on_hint_timer_timeout():
	if _locked:
		return
	hint.visible = true

func _hour_plus():
	if _locked: return
	hour_pivot.rotation_degrees += step_hour
	_check_solved()

func _hour_minus():
	if _locked: return
	hour_pivot.rotation_degrees -= step_hour
	_check_solved()

func _min_plus():
	if _locked: return
	minute_pivot.rotation_degrees += step_minute
	_check_solved()

func _min_minus():
	if _locked: return
	minute_pivot.rotation_degrees -= step_minute
	_check_solved()

func _check_solved():
	if _locked:
		return

	var h = _norm(hour_pivot.rotation_degrees)
	var m = _norm(minute_pivot.rotation_degrees)
	var ok_h = abs(_angle_diff(h, _norm(target_hour_deg))) <= tolerance_deg
	var ok_m = abs(_angle_diff(m, _norm(target_minute_deg))) <= tolerance_deg
	if ok_h and ok_m:
		_resolve()

func _resolve():
	_locked = true
	_completed = true
	hint.visible = false
	hint_timer.stop()
	hour_pivot.rotation_degrees = target_hour_deg
	minute_pivot.rotation_degrees = target_minute_deg
	btn_h_plus.disabled = true
	btn_h_minus.disabled = true
	btn_m_plus.disabled = true
	btn_m_minus.disabled = true
	target_hour_pivot.visible = false
	target_minute_pivot.visible = false
	if sfx.stream:
		sfx.play()
		yield(sfx, "finished")
	Notes.add("mutations_1")
	Notes.set_flag("clock_house1_done", true)
	emit_signal("solved")
	visible = false

func _norm(d):
	var x = fmod(d, 360.0)
	if x < 0:
		x += 360.0
	return x

func _angle_diff(a, b):
	return fmod(a - b + 540.0, 360.0) - 180.0
