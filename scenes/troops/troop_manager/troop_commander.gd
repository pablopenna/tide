class_name TroopCommander extends Node

@export var troop_detectors: Array[TroopDetector]
@export var troops: TroopTracker
	
func _ready() -> void:
	for detector in self.troop_detectors:
		if not detector.is_node_ready():
			await detector.ready
		detector.targets_acquired.connect(make_troops_attack_targets)
	
func make_troops_attack_targets(targets: Array):
	var target = targets[0]
	for troop in troops.get_all_troops():
		troop.attack_target(target)
		
func make_troops_follow_leader():
	for troop in troops.get_all_troops():
		troop.follow_owner()
