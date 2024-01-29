extends CharacterBody2D


@export var hp: Array[int] = [0, 0]
@export var base_stats: Array[int] = [0, 0, 0, 0, 0]
@export var harmonics: Array[int] = [0, 0, 0, 0, 0]
@export var curr_stage: Array[int] = [0, 0, 0, 0, 0]
@export var status: int = 0
@export var char_name: String = ""
@export var team: int = 1

signal died

func set_values(max_hp, curr_hp, stats, curr_harmonics, curr_status, curr_name, curr_team) -> void:
	hp = [curr_hp, max_hp]
	base_stats = stats
	harmonics = curr_harmonics
	stats = curr_status
	char_name = curr_name
	team = curr_team
	
func damage(d: int) -> void:
	hp[0] -= d
	if hp[0] < 0:
		hp[0] = 0
		emit_signal('died')
	else:
		hp[0] = min(hp)
		
func getStats() -> Array:
	var curr_stats = [0, 0, 0, 0, 0]
	for idx in range(5):
		curr_stats[idx] = max(base_stats[idx] + int(base_stats[idx] * curr_stage[idx] * .5), 0)
	return curr_stats
		

