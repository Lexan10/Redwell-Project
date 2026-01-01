extends Node2D

onready var npc_divertit = $YSort/NPC
onready var npc_cientifica = $YSort/NPC3
onready var npc_forcut = $YSort/NPC4
onready var npc_tecnic = $YSort/NPC5
onready var chair1 = $YSort/Chair1
onready var world = $YSort/World
onready var plant = $YSort/Plant
onready var butaca = $YSort/Butaca
onready var clock = $YSort/Clock
onready var informe = $YSort/Informe

func _ready():
	if Notes.has_flag("clock_house1_done"):
		clock.set_completed(true)
		if Notes.has("mutations_1"):
			informe.visible = false
		else:
			informe.activate()
	print("InsideHouse1: selected_companion =", DialogueAutoload.selected_companion)
	if not BgMusic.playing:
		BgMusic.play()
	npc_cientifica.visible = false
	npc_forcut.visible = false
	npc_tecnic.visible = false
	npc_divertit.visible = false
	match DialogueAutoload.selected_companion:
		"cientifica":
			npc_cientifica.visible = true
			plant.visible = false
		"forcut":
			npc_forcut.visible = true
			chair1.visible = false
		"tecnic":
			npc_tecnic.visible = true
			world.visible = false
		"divertit":
			npc_divertit.visible = true
			butaca.visible = false
		_:
			pass
