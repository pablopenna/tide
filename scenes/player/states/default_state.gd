extends State

@export var speed: float
var input: Vector2
@export var troop_manager: TroopManager

func _ready():
	state_name = "default"
	input = Vector2.ZERO

func process(_delta):
	var raw_input: Vector2 = Vector2(Input.get_axis("ui_left","ui_right"), Input.get_axis("ui_up","ui_down"))
	input = raw_input.normalized()
	managed_entity.velocity = input * speed
	
	if Input.is_action_just_pressed("add_player_troop"):
		troop_manager.create_troop()
		
	if Input.is_action_just_pressed("attack"):
		troop_manager.make_troops_follow_leader()

func _on_enemy_detector_targets_acquired(target_hurtbox):
	troop_manager.make_troops_attack_targets(target_hurtbox)
