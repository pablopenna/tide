extends CharacterBody2D

@export var target: Node2D
@export var speed: float
@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var navigation_refresh_time = 100
@onready var last_navigation_refresh = Time.get_ticks_msec()

func _physics_process(_delta):
	print("is target reachable: " + str(nav.is_target_reachable()))
	print("is target reached: " + str(nav.is_target_reached()))
	print("is navigation finished: " + str(nav.is_navigation_finished()))
	print("========")
	
	nav.target_position = target.position
	velocity = position.direction_to(nav.get_next_path_position()).normalized() * speed
	move_and_slide()
