extends Button

var playback
@onready var player = $AudioStreamPlayer
@onready var sample_hz = player.stream.mix_rate
@onready var spinbox = %DutyCycleInput

func _ready():
	$AudioStreamPlayer.play()
	playback = $AudioStreamPlayer.get_stream_playback()
	pressed.connect(fill_buffer)

func fill_buffer():
	var phase = 0.0
	var increment = %TEMP_Frequency.value / sample_hz
	var frames_available = playback.get_frames_available()
	#print(frames_available)
	
	# pulse wave
	var duty_cycle = (2 * spinbox.value / 100) - 1
	for i in range(frames_available):
		playback.push_frame(Vector2.ONE * (1 if sin(phase * TAU) >= duty_cycle else -1))
		phase = fmod(phase + increment, 1.0)
