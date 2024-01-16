extends Node

@export var player_data: PlayerData
	
func _on_overworld_body_collision():
	player_data.hp -= 1
	
func addInventory(i):
	if is_instance_of(i, Orb):
		for o in player_data.inventory.OrbList:
			if not o:
				o = i
				break
	elif is_instance_of(i, Equipment):
		for e in player_data.inventory.EquipList:
			if not e:
				e = i
				break
	elif is_instance_of(i, ItemData):
		for e in player_data.inventory.ConsumableList:
			if not e:
				e = i
			elif e.id == i.id:
				e.amount += i.amount
