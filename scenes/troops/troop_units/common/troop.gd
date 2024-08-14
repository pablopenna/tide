class_name Troop extends Entity

var troop_type: TroopTypes.Type
var stats: Stat

@export var faction: FactionContainer
@export var hp_manager: HealthPointsManager

var troop_owner: Node2D
var following_owner_target_position_offset: Vector2
var target: Node2D
var speed: float

@export var hurtbox: Hurtbox
var hurtbox_layer: int:
	set(value):
		hurtbox_layer = value
		hurtbox.collision_layer = value

@export var hitbox: Hitbox
var hitbox_layer: int:
	set(value):
		hitbox_layer = value
		if hitbox:
			hitbox.collision_mask = value

signal died(troop: Troop)
signal ordered_to_attack(target: Node2D)
signal ordered_to_follow_leader
signal _provide_damage(damage:int)

func _ready() -> void:
	hp_manager.health_zeroed.connect(_on_die)
	_init_stats()

func _init_stats() -> void:
	self.stats = TroopStats.stats[troop_type]
	self.speed = randf_range(stats.min_speed, stats.max_speed)
	_provide_damage.emit(stats.damage)

func initialize_with(troop_owner: Node2D, position_offset: Vector2, faction: FactionUtils.Faction) -> void:
	self.faction.faction = faction
	self.troop_owner = troop_owner
	self.following_owner_target_position_offset = position_offset
	hitbox_layer = FactionUtils.get_hitbox_collision_mask_for_faction(faction)
	hurtbox_layer = FactionUtils.get_hurtbox_collision_layer_for_faction(faction)
	self.position = troop_owner.position

func attack_target(target: Node2D) -> void:
	self.target = target
	
func follow_owner() -> void:
	self.target = troop_owner

func _on_die() -> void:
	died.emit(self)
	queue_free()
