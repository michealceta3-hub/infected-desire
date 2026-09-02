extends Control

func _ready():
	$PanelContainer/VBoxContainer/LanguageOptionButton.connect("item_selected", self, "_on_language_changed")
	$PanelContainer/VBoxContainer/LanguageOptionButton.select(0 if LocalizationManager.current_language == "ru" else (1 if LocalizationManager.current_language == "en" else 2))
	
	$PanelContainer/VBoxContainer/CensorshipCheckBox.connect("toggled", self, "_on_censorship_toggled")
	$PanelContainer/VBoxContainer/CensorshipCheckBox.pressed = true
	
	$PanelContainer/VBoxContainer/VolumeSlider.connect("value_changed", self, "_on_volume_changed")
	$PanelContainer/VBoxContainer/VolumeSlider.value = AudioManager.master_volume
	
	$PanelContainer/VBoxContainer/BackButton.connect("pressed", self, "_on_back_pressed")

func _on_language_changed(index: int):
	var languages = ["ru", "en", "ro"]
	if index < languages.size():
		LocalizationManager.set_language(languages[index])

func _on_censorship_toggled(pressed: bool):
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.censorship_enabled = pressed

func _on_volume_changed(value: float):
	AudioManager.set_master_volume(value)

func _on_back_pressed():
	queue_free()
