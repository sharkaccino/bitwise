extends Button

var playback
@onready var player = $AudioStreamPlayer
@onready var sample_hz = player.stream.mix_rate

func _ready():
	$AudioStreamPlayer.play()
	playback = $AudioStreamPlayer.get_stream_playback()
	pressed.connect(fill_buffer)

func fill_buffer():
	var frames_available = playback.get_frames_available()
	#print(frames_available)
	
	var attack = round(frames_available * 0.015)
	var release = round(frames_available * 0.2)
	
	var current_freq = Vector2.ONE * (randf() * 2 - 1)
	for i in range(frames_available):
		var level = min(1.0, 1 / (attack / i))
		level = level - max(0, ((i - (frames_available - release)) / release))
		
		if i % roundi(sample_hz / %TEMP_Frequency.value) == 0:
			current_freq = Vector2.ONE * (randf() * 2 - 1) * level
		playback.push_frame(current_freq * level)
