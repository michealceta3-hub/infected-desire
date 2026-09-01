extends Node

var master_volume = 0.0
var music_volume = -5.0
var sfx_volume = -5.0
var voice_volume = -5.0

var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer
var voice_player: AudioStreamPlayer

func _ready():
	setup_audio_buses()

func setup_audio_buses():
	AudioServer.set_bus_mute(0, false)

func play_music(resource: AudioStream, volume: float = -5.0):
	if not music_player:
		return
	music_player.stream = resource
	music_player.volume_db = volume
	music_player.play()

func play_sfx(resource: AudioStream, volume: float = 0.0):
	if not sfx_player:
		return
	sfx_player.stream = resource
	sfx_player.volume_db = volume
	sfx_player.play()

func set_master_volume(volume: float):
	master_volume = volume
	AudioServer.set_bus_mute(0, volume <= -80.0)

func set_music_volume(volume: float):
	music_volume = volume

func set_sfx_volume(volume: float):
	sfx_volume = volume

func set_voice_volume(volume: float):
	voice_volume = volume
