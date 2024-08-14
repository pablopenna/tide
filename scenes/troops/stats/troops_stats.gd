class_name TroopStats extends Resource

static var stats: Dictionary = {
	TroopTypes.Type.KNIGHT: Stat.new(40, 10, 5, 14, 70, 80, -1, -1),
	TroopTypes.Type.ARCHER: Stat.new(10, 10, 3, 100, 80, 100, 300, 1000),
	TroopTypes.Type.DRAGON: Stat.new(100, 100, 20, 120, 50, 60, 400, 2000),
}
