extends Label

func _update() -> void:
	var raw_value = Performance.get_monitor(Performance.AUDIO_OUTPUT_LATENCY)
	var rounded = snappedf(raw_value, 0.01)
	
	text = str("Latency: ", rounded, " ms")
	await get_tree().create_timer(1).timeout
	_update()

func _ready() -> void:
	_update()
