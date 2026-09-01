extends CanvasLayer

var hp_bar: ProgressBar
var stamina_bar: ProgressBar
var pregnancy_bar: ProgressBar
var hp_label: Label
var stamina_label: Label
var pregnancy_label: Label

func _ready():
	hp_bar = $HPBar
	stamina_bar = $StaminaBar
	pregnancy_bar = $PregnancyBar
	hp_label = $HPLabel
	stamina_label = $StaminaLabel
	pregnancy_label = $PregnancyLabel

	GlobalSignals.connect("player_hp_changed", self, "_on_hp_changed")
	GlobalSignals.connect("player_stamina_changed", self, "_on_stamina_changed")
	GlobalSignals.connect("player_pregnancy_changed", self, "_on_pregnancy_changed")

func _on_hp_changed(hp: float, max_hp: float):
	if hp_bar:
		hp_bar.max_value = max_hp
		hp_bar.value = hp
	if hp_label:
		hp_label.text = "HP: %.0f/%.0f" % [hp, max_hp]

func _on_stamina_changed(stamina: float, max_stamina: float):
	if stamina_bar:
		stamina_bar.max_value = max_stamina
		stamina_bar.value = stamina
	if stamina_label:
		stamina_label.text = "Stamina: %.0f" % stamina

func _on_pregnancy_changed(pregnancy: float, max_pregnancy: float):
	if pregnancy_bar:
		pregnancy_bar.max_value = max_pregnancy
		pregnancy_bar.value = pregnancy
	if pregnancy_label:
		pregnancy_label.text = "Infection: %.0f%%" % (pregnancy / max_pregnancy * 100)
