class_name StateManager extends Node

var states: Dictionary
var current_state: State = initial_state
@export var initial_state: State
@export var managed_entity: Entity

signal state_changed(new_state: String, old_state: String)

func _ready():
	states = get_children_as_state_dictionary()
	initialize_states()
	current_state = initial_state
	

func _process(delta):
	current_state.process(delta)

func _physics_process(delta):
	current_state.physics_process(delta)

func get_children_as_state_dictionary() -> Dictionary:
	var children: Array[Node] = self.get_children()
	var states: Dictionary = {}
	
	for child in children as Array[State]:
		states[child.state_name] = child
		
	return states
	
func initialize_states():
	for stateKey in states:
		var state: State = states[stateKey]
		
		state.change_to_state.connect(on_change_to_state)
		state.managed_entity = self.managed_entity

func on_change_to_state(new_state_name: String):
	var old_state = current_state
	var new_state = states[new_state_name]
	
	old_state.exit(new_state)
	current_state = new_state
	new_state.enter()
	
	state_changed.emit(new_state_name, old_state.state_name)
