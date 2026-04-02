extends HSlider

func _update_master_volume(new_value) -> void:
	AudioServer.set_bus_volume_linear(0, new_value / 100)
	print("new master vol: ", AudioServer.get_bus_volume_linear(0))

func _ready() -> void:
	_update_master_volume(value)
	value_changed.connect(_update_master_volume)
