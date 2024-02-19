class_name Hitbox extends Area2D

var entity_to_track: Entity
var hitbox_data: HitboxData

func _ready():
	area_entered.connect(_on_area_entered)
	hitbox_data = find_children("*", "HitboxData")[0]
	
func _process(delta):
	if entity_to_track:
		_flip_horizontally_if_entity_facing_left()
		_set_position_relative_to_entity()
	
func _on_area_entered(area: Area2D):
	var hurtbox = area as Hurtbox # Casting returns null if cannot convert to type
	if hurtbox == null:
		return	
	_on_hurtbox_entered(hurtbox)
	
func enable():
	monitoring = true
	monitorable = true

func disable():
	monitoring = false
	monitorable = false
	
func _on_hurtbox_entered(hurtbox: Hurtbox):
	hurtbox.receiveDamage(hitbox_data)
	
func _flip_horizontally_if_entity_facing_left():
	if entity_to_track.facing_direction == FacingDirectionUtils.FacingDirection.LEFT:
		self.scale.x = -1
	else:
		self.scale.x = 1
		
func _set_position_relative_to_entity():
	self.position = entity_to_track.position
