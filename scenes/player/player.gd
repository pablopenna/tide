extends Entity

@export var speed: float = 200
var input: Vector2
@export var commander: TroopCommander
@export var factory: TroopFactory
@export var animation_player: AnimationPlayer
@export var player_mana: Mana

func _ready() -> void:
	input = Vector2.ZERO
	player_mana.mana_changed.connect(func(amount: int): GlobalEvents.player_mana_changed.emit(amount))

func _process(_delta: float) -> void:
	_process_input()
	_process_animation()
	velocity = input * speed

func _process_input() -> void:
	var raw_input: Vector2 = Vector2(Input.get_axis("ui_left","ui_right"), Input.get_axis("ui_up","ui_down"))
	input = raw_input.normalized()
	
	if Input.is_action_just_pressed("player_troop_add_knight"):
		if player_mana.spend(1):
			factory.create_knight()
	if Input.is_action_just_pressed("player_troop_add_archer"):
		if player_mana.spend(1):
			factory.create_archer()
	if Input.is_action_just_pressed("player_troop_regroup"):
		commander.make_troops_follow_leader()

func _process_animation() -> void:
	if velocity == Vector2.ZERO:
		animation_player.play("idle_down")
	elif facing_direction == Vector2.UP:
		animation_player.play("walk_up")
	elif facing_direction == Vector2.DOWN:
		animation_player.play("walk_down")
	else:
		animation_player.play("walk_right")
