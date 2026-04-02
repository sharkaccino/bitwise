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
	var increment = sample_hz / %TEMP_Frequency.value
	var frames_available = playback.get_frames_available()
	#print(frames_available)
	
	var attack = round(frames_available * 0.015)
	var release = round(frames_available * 0.2)
	
	# triangle wave
	for i in range(frames_available):
		var level = min(1.0, 1 / (attack / i))
		level = level - max(0, ((i - (frames_available - release)) / release))
		
		# normal
		playback.push_frame(Vector2.ONE * (abs((fmod(i, increment) / increment) * 2 - 1) * 2 - 1) * level)
		# 2A03
		#playback.push_frame(Vector2.ONE * snappedf(abs((fmod(i, increment) / increment) * 2 - 1) * 2 - 1, 1.0 / 8) * level)
		phase = fmod(phase + increment, 1.0)
