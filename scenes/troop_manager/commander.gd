extends Node

var troop_detector: TroopDetector
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

func _on_troop_manager_troop_detector_provided(troop_detector):
	self.troop_detector = troop_detector
	if not self.troop_detector.is_node_ready():
		await self.troop_detector.ready
	self.troop_detector.targets_acquired.connect(make_troops_attack_targets)
