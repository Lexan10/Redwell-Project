extends StaticBody2D

export(String) var sign_text = "Redwell Town ->"

onready var label = $Text/Label

func _ready():
	label.text = sign_text
	label.visible = false

func _on_Text_body_entered(body):
	if body.name == "Player":
		label.visible = true

func _on_Text_body_exited(body):
	if body.name == "Player":
		label.visible = false
