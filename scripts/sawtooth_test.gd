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
	
	# sawtooth wave
	for i in range(frames_available):
		playback.push_frame(Vector2.ONE * (((fmod(i * -1, increment) / increment) * 2.0) + 1.0) )
		phase = fmod(phase + increment, 1.0)
