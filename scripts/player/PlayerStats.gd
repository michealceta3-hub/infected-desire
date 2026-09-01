extends Node

class_name PlayerStats

var max_hp = 100.0
var hp = 100.0
var max_stamina = 100.0
var stamina = 100.0
var max_pregnancy = 100.0
var pregnancy = 0.0

var stamina_regen_rate = 50.0  # Per second
var stamina_recovery_delay = 0.5

var last_attacker_type = ""

func _ready():
	hp = max_hp
	stamina = max_stamina

func _process(delta):
	if stamina < max_stamina:
		stamina += stamina_regen_rate * delta
		stamina = clamp(stamina, 0.0, max_stamina)
		GlobalSignals.emit_signal("player_stamina_changed", stamina, max_stamina)

func take_damage(damage: float, attacker_type: String = "") -> bool:
	hp -= damage
	last_attacker_type = attacker_type
	GlobalSignals.emit_signal("player_hp_changed", hp, max_hp)
	if hp <= 0:
		hp = 0
		GlobalSignals.emit_signal("player_defeated", attacker_type)
		return true
	return false

func heal(amount: float):
	hp += amount
	hp = clamp(hp, 0.0, max_hp)
	GlobalSignals.emit_signal("player_hp_changed", hp, max_hp)

func use_stamina(amount: float) -> bool:
	if stamina >= amount:
		stamina -= amount
		GlobalSignals.emit_signal("player_stamina_changed", stamina, max_stamina)
		return true
	return false

func restore_stamina(amount: float):
	stamina += amount
	stamina = clamp(stamina, 0.0, max_stamina)
	GlobalSignals.emit_signal("player_stamina_changed", stamina, max_stamina)

func increase_pregnancy(amount: float):
	pregnancy += amount
	pregnancy = clamp(pregnancy, 0.0, max_pregnancy)
	GlobalSignals.emit_signal("player_pregnancy_changed", pregnancy, max_pregnancy)

func restore_health():
	hp = max_hp
	GlobalSignals.emit_signal("player_hp_changed", hp, max_hp)
