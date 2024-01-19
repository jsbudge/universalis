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
				
func setActiveOrb(i: int):
	player_data.active_orb = i
	
func equip(i: Equipment):
	var e_slot = i.slot
	if player_data.equipped[e_slot]:
		player_data.inventory.EquipList.append(player_data.equipped[e_slot])
	player_data.equipped[e_slot] = i
		
func readyOrb(i: Orb, slot_num: int):
	if player_data.ready_orbs[slot_num]:
		player_data.inventory.OrbList.append(player_data.ready_orbs[slot_num])
	player_data.ready_orbs[slot_num] = i
		
