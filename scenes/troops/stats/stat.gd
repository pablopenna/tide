class_name Stat extends RefCounted

var hp: int
var damage: int
var range: int
var min_speed: float
var max_speed: float
var mana_cost: int
var projectile_speed: float
var shooting_cooldown_ms: int 

func _init(
	hp:int, 
	mana_cost: int,
	damage: int, 
	range: int,
	min_speed: float, 
	max_speed: float, 
	projectile_speed: float,
	shooting_cooldown_ms: int
):
	self.hp = hp
	self.mana_cost = mana_cost
	self.damage = damage
	self.range = range
	self.min_speed = min_speed
	self.max_speed = max_speed
	self.projectile_speed = projectile_speed
	self.shooting_cooldown_ms = shooting_cooldown_ms
