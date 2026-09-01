extends Node

# Player signals
signal player_hp_changed(hp, max_hp)
signal player_stamina_changed(stamina, max_stamina)
signal player_pregnancy_changed(pregnancy, max_pregnancy)
signal player_died
signal player_defeated(attacker_type)
signal player_recovered

# Level signals
signal level_loaded(level_name)
signal level_complete

# Enemy signals
signal enemy_spawned(enemy)
signal enemy_died(enemy)

# Game state signals
signal game_paused
signal game_resumed
signal game_over(pregnancy)
