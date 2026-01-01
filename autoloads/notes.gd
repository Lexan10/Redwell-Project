extends Node

var unlocked := {}
var flags := {}

const TEXT := {
	"mutations_1": """INFORME SOBRE MUTACIONS — ARXIU 1
Responsable: Dr. Lockwood
Els primers assajos han iniciat segons el previst.
Cap a mitja tarda, un subjecte ha mostrat una reaccio inesperada.
He anotat l’hora exacta de l’incident.
No es un detall que s’hagi d’oblidar.
"""
}

func add(id: String) -> void:
	unlocked[id] = true

func has(id: String) -> bool:
	return unlocked.has(id)

func get_text(id: String) -> String:
	return TEXT.get(id, "")

func set_flag(key: String, value := true) -> void:
	flags[key] = value

func has_flag(key: String) -> bool:
	return flags.has(key) and flags[key] == true
