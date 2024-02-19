extends Node

@export var target: Node2D
@onready var small_box: Node2D = $SmallBox
@onready var big_box: Node2D = $BigBox

func _ready():
	small_box.target = target
