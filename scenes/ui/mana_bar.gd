extends TextureProgressBar

func _ready() -> void:
	GlobalEvents.player_mana_changed.connect(_set_mana_bar)

func _set_mana_bar(value: int) -> void:
	self.value = value
