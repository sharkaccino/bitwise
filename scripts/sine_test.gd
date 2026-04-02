extends Button

var playback
@onready var player = $AudioStreamPlayer
@onready var sample_hz = player.stream.mix_rate

func _ready():
	$AudioStreamPlayer.play()
	playback = $AudioStreamPlayer.get_stream_playback()
	pressed.connect(fill_buffer)

func fill_buffer():
	var phase = 0.0
	var increment = %TEMP_Frequency.value / sample_hz
	var frames_available = playback.get_frames_available()
	#print(frames_available)
	
	var attack = round(frames_available * 0.015)
	var release = round(frames_available * 0.2)

	# sine wave
	for i in range(frames_available):
		var level = min(1.0, 1 / (attack / i))
		level = level - max(0, ((i - (frames_available - release)) / release))
		
		playback.push_frame(Vector2.ONE * sin(phase * TAU) * level)
		phase = fmod(phase + increment, 1.0)
