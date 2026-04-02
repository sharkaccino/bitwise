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
	
	var current_freq = Vector2.ONE * (randf() * 2 - 1)
	for i in range(frames_available):
		if i % roundi(sample_hz / %TEMP_Frequency.value) == 0:
			current_freq = Vector2.ONE * (randf() * 2 - 1)
		playback.push_frame(current_freq)
