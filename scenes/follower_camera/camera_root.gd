extends Camera2D

@export var target: Node2D
@onready var small_box: Node2D = $SmallBox
@onready var big_box: Node2D = $BigBox

func _ready():
	small_box.target = target
	
func _process(_delta):
	position = big_box.position
