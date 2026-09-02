extends Node

# Dialogue box UI controller
class_name DialogueUI

var dialogue_box: PanelContainer
var speaker_label: Label
var text_label: Label
var speaker_portrait: TextureRect
var is_animating = false

func _ready():
	dialogue_box = $DialogueBox
	speaker_label = $DialogueBox/VBoxContainer/SpeakerLabel
	text_label = $DialogueBox/VBoxContainer/TextLabel

	if has_node("DialogueBox/VBoxContainer/Portrait"):
		speaker_portrait = $DialogueBox/VBoxContainer/Portrait

func show_dialogue(speaker: String, text: String, portrait_path: String = "") -> void:
	if speaker_label:
		speaker_label.text = speaker
	if text_label:
		text_label.text = text
	if portrait_path and speaker_portrait:
		if ResourceLoader.exists(portrait_path):
			speaker_portrait.texture = load(portrait_path)
			speaker_portrait.show()

	if dialogue_box:
		dialogue_box.show()

func hide_dialogue() -> void:
	if dialogue_box:
		dialogue_box.hide()

func animate_text(text: String, speed: float = 0.05) -> void:
	if text_label:
		is_animating = true
		text_label.text = ""
		for character in text:
			text_label.text += character
			yield(get_tree(), "idle_frame")
			yield(get_tree().create_timer(speed), "timeout")
		is_animating = false
