extends State

@export var speed: float
var input: Vector2

func _ready():
	state_name = "default"
	input = Vector2.ZERO

func process(delta):
	var raw_input: Vector2 = Vector2(Input.get_axis("ui_left","ui_right"), Input.get_axis("ui_up","ui_down"))
	input = raw_input.normalized()


func physics_process(delta):
	managed_entity.velocity = input * speed
