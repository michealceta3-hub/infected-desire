extends Control

func _ready():
	$Panel/VBoxContainer/BackButton.connect("pressed", self, "_on_back_pressed")

func _on_back_pressed():
	queue_free()
