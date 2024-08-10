class_name TroopTracker extends Node

@export var factory: TroopFactory
var _troops: Array[Troop]

func _ready() -> void:
	if factory:
		factory.troop_created.connect(add_troop)

func add_troop(troop: Troop) -> void:
	#if _troops.has(troop):
	_troops.append(troop)
	troop.died.connect(remove_troop)

func remove_troop(troop: Troop) -> void:
	_troops.erase(troop)

func get_all_troops() -> Array[Troop]:
	return _troops.duplicate()

func pop_troop() -> Troop:
	return _troops.pop_back()
