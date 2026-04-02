extends Control

@onready var analyzer: AudioEffectSpectrumAnalyzerInstance = AudioServer.get_bus_effect_instance(0, 2)

var global_max_freq = 16000

func _draw() -> void:
	var bars = roundi(size.x)
	@warning_ignore("integer_division")
	var freq_range = roundi(global_max_freq / bars)
	var bar_width = (size.x / bars)
	
	for i in range(bars):
		var min_freq = 0 if i == 0 else i * freq_range
		var max_freq = global_max_freq if i+1 == bars else (i+1) * freq_range
		var magnitude = analyzer.get_magnitude_for_frequency_range(min_freq, max_freq)
		
		var h_pos = bar_width * i
		var start = Vector2(h_pos, (size.y / 2 - 0.5) - (size.y * magnitude.x))
		var end = Vector2(h_pos, (size.y / 2 + 0.5) + (size.y * magnitude.x))
		
		draw_line(start, end, Color("white"), max(1, bar_width - 2))

func _process(_delta) -> void:
	queue_redraw()
