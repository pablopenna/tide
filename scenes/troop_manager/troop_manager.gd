class_name TroopManager extends Node

@export var troop_owner: Entity
@export var troop_detectors: Array[TroopDetector]
@export_flags_2d_physics var troops_hitbox_layer_scanned: int
@export_flags_2d_physics var troops_hurtbox_layer: int
@onready var troops: Array[Troop] = []

signal troop_owner_provided(troop_owner: Entity)
signal troop_detectors_provided(troop_detectors: Array)
signal troops_hitbox_layer_scanned_provided(hitbox: Hitbox)
signal troops_hurtbox_layer_provided(hurtbox: Hurtbox)
signal troops_provided(troops: Array[Troop])

@onready var _commander = $Commander
@onready var _factory = $Factory

func _ready() -> void:
	troop_owner_provided.emit(troop_owner)
	troop_detectors_provided.emit(troop_detectors)
	troops_hitbox_layer_scanned_provided.emit(troops_hitbox_layer_scanned)
	troops_hurtbox_layer_provided.emit(troops_hurtbox_layer)
	troops_provided.emit(troops)
	
func create_knight() -> void:
	_factory.create_knight()
	
func create_archer() -> void:
	_factory.create_archer()

func make_troops_attack_targets(targets: Array) -> void:
	_commander.make_troops_attack_targets(targets)

func make_troops_follow_leader() -> void:
	_commander.make_troops_follow_leader()
