extends Control

@onready var capture: AudioEffectCapture = AudioServer.get_bus_effect(0, 1)

var buffer = PackedVector2Array()

func _ready() -> void:
	for i in range(size.x):
		buffer.append(Vector2(0,0))

func _draw() -> void:
	for i in range(size.x):
		var start = Vector2(i, (size.y / 2) + (size.y * buffer[max(0, i-1)].x / 2))
		var end = Vector2(i+1, (size.y / 2) + (size.y * buffer[i].x / 2));
		draw_line(start, end, Color("white"), 0.5, true)

func _process(_delta) -> void:
	var frames = capture.get_frames_available()
	if (frames > 0):
		buffer = capture.get_buffer(frames)
		queue_redraw()
