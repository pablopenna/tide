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
	
	if Input.is_action_just_pressed("player_troop_add_knight"):
		troop_manager.create_knight()
		
	if Input.is_action_just_pressed("player_troop_add_archer"):
		troop_manager.create_archer()
		
	if Input.is_action_just_pressed("player_troop_regroup"):
		troop_manager.make_troops_follow_leader()
