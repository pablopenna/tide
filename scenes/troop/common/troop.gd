class_name Troop extends Entity

@export var faction: FactionContainer
@export var hp_manager: HealthPointsManager

var troop_owner: Node2D
var following_owner_target_position_offset: Vector2
var speed: int
var target: Node2D
var range: int

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
			hitbox.collision_layer = value


signal died(troop: Troop)
signal ordered_to_attack(target: Node2D)
signal ordered_to_follow_leader

func _ready() -> void:
	hp_manager.health_zeroed.connect(_on_die)

func initialize_with(troop_owner: Node2D, position_offset: Vector2, speed: float, faction: FactionUtils.Faction) -> void:
	self.faction.faction = faction
	self.troop_owner = troop_owner
	self.following_owner_target_position_offset = position_offset
	self.speed = speed
	hitbox_layer = FactionUtils.get_hitbox_collision_mask_for_faction(faction)
	hurtbox_layer = FactionUtils.get_hurtbox_collision_layer_for_faction(faction)
	self.position = troop_owner.position

func attack_target(target: Node2D) -> void:
	self.target = target
	
func follow_owner() -> void:
	self.target = troop_owner

#func set_hurtbox_layer(layer: int) -> void:
	#hurtbox_layer = layer
	#hurtbox.collision_layer = layer
	#
#func set_hitbox_layer(layer: int) -> void:
	#hitbox_layer = layer
	#if hitbox:
		#hitbox.collision_mask = layer

func _on_die() -> void:
	died.emit(self)
	queue_free()
