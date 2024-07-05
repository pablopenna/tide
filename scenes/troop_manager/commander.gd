extends Node

var troop_detectors: Array[TroopDetector]
var troops: Array[Troop]
	
func make_troops_attack_targets(targets: Array):
	var target = targets[0]
	for troop in troops:
		troop.attack_target(target)
		
func make_troops_follow_leader():
	for troop in troops:
		troop.follow_owner()

func _on_troop_manager_troops_provided(troops):
	self.troops = troops

func _on_troop_manager_troop_detectors_provided(troop_detectors):
	self.troop_detectors = troop_detectors
	for detector in self.troop_detectors:
		if not detector.is_node_ready():
			await detector.ready
		detector.targets_acquired.connect(make_troops_attack_targets)
