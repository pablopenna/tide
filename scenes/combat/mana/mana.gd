class_name Mana extends Node

@export var initial_mana_points: int
@export var max_mana_points: int
@export var mana_regen_quantity: int
@export var mana_regen_cooldown: float
@export var mana_regen_timer: Timer

var _mana_points: int:
	set(value):
		_mana_points = value
		mana_changed.emit(_mana_points)

signal mana_changed(amount: int)

func _ready() -> void:
	_mana_points = initial_mana_points
	mana_regen_timer.timeout.connect(func():increase(mana_regen_quantity))
	mana_regen_timer.start(mana_regen_cooldown)

func get_mana_points() -> int:
	return _mana_points

func has_enough_mana_points_for(amount: int) -> bool:
	return _mana_points >= amount

func spend(amount: int) -> bool:
	if not has_enough_mana_points_for(amount):
		return false
	_mana_points -= amount
	return true

func increase(amount: int) -> void:
	_mana_points += amount
	_mana_points = clampi(_mana_points, 0, max_mana_points)
