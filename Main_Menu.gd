extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var start_sound = $AudioStreamPlayer2

# Called when the node enters the scene tree for the first time.
func _ready():
	start_sound.connect("finished", self, "_on_start_sound_finished")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_start_pressed():
	start_sound.play()


func _on_start_sound_finished():
	get_tree().change_scene("res://Town.tscn")

func _on_options_pressed():
	print("Options pressed")


func _on_exit_pressed():
	get_tree().quit()

