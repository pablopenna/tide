class_name TroopManager extends Node

@export var troop_owner: Entity
@export var troop_detectors: Array[TroopDetector]
@export_flags_2d_physics var troops_hitbox_layer_scanned
@export_flags_2d_physics var troops_hurtbox_layer
@onready var troops: Array[Troop] = []

signal troop_owner_provided(troop_owner)
signal troop_detectors_provided(troop_detectors)
signal troops_hitbox_layer_scanned_provided(hitbox)
signal troops_hurtbox_layer_provided(hurtbox)
signal troops_provided(troops)

@onready var _commander = $Commander
@onready var _factory = $Factory

func _ready():
	troop_owner_provided.emit(troop_owner)
	troop_detectors_provided.emit(troop_detectors)
	troops_hitbox_layer_scanned_provided.emit(troops_hitbox_layer_scanned)
	troops_hurtbox_layer_provided.emit(troops_hurtbox_layer)
	troops_provided.emit(troops)
	
func create_knight():
	_factory.create_knight()
	
func create_archer():
	_factory.create_archer()

func make_troops_attack_targets(targets: Array):
	_commander.make_troops_attack_targets(targets)

func make_troops_follow_leader():
	_commander.make_troops_follow_leader()
