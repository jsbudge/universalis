extends Node

@export var player_data: PlayerData
	
func _on_overworld_body_collision():
	player_data.hp -= 1
	
func addInventory(i):
	if is_instance_of(i, Orb):
		for o in player_data.inventory.OrbList:
			if not o:
				o = i
				return
		player_data.inventory.OrbList.append(i)
	elif is_instance_of(i, Equipment):
		for e in player_data.inventory.EquipList:
			if not e:
				e = i
				return
		player_data.inventory.EquipList.append(i)
	elif is_instance_of(i, ItemData):
		for e in player_data.inventory.ConsumableList:
			if not e:
				e = i
				return
			elif e.id == i.id:
				e.amount += i.amount
				return
		player_data.inventory.ConsumableList.append(i)
	
func setActiveOrb(i: int):
	player_data.active_orb = i
	
func getActiveOrb() -> Orb:
	return player_data.ready_orbs[player_data.active_orb]
	
func equip(i: Equipment):
	var e_slot = i.slot
	if player_data.equipped[e_slot]:
		player_data.inventory.EquipList.append(player_data.equipped[e_slot])
	player_data.equipped[e_slot] = i
		
func readyOrb(i: Orb, slot_num: int):
	if player_data.ready_orbs[slot_num]:
		player_data.inventory.OrbList.append(player_data.ready_orbs[slot_num])
	player_data.ready_orbs[slot_num] = i
	
func getArray(_type: int) -> Array:
	if _type == 0:
		return player_data.inventory.OrbList
	elif _type == 1:
		return player_data.inventory.EquipList
	elif _type == 2:
		return player_data.inventory.ConsumableList
	elif _type == 3:
		return player_data.ready_orbs
	elif _type == 4:
		return player_data.equipped
	else:
		return player_data.ready_orbs
		
func swapItems(swap_from, swap_to):
	var from_array = getArray(swap_from[0])
	var to_array = getArray(swap_to[0])
	var from_data = from_array[swap_from[1]]
	var to_data = to_array[swap_to[1]]
	from_array[swap_from[1]] = to_data
	to_array[swap_to[1]] = from_data
	if swap_from[0] < 3:
		for f in from_array:
			if not f:
				from_array.erase(f)
	if swap_to[0] < 3:
		for f in to_array:
			if not f:
				to_array.erase(f)


func moveItem(swap_from: Array, swap_to: int):
	# Function intended for moving something from active area to inventory
	var from_array = getArray(swap_from[0])
	var to_array = getArray(swap_to)
	var from_data = from_array[swap_from[1]]
	to_array.append(from_data)
	from_array[swap_from[1]] = null


func getModStats() -> Array:
	var fullstats = [0, 0, 0, 0, 0]
	var itemstats = [0, 0, 0, 0, 0]
	for i in range(5):
		for n in range(5):
			if player_data.ready_orbs[n]:
				itemstats[i] += player_data.ready_orbs[n].stat_modifiers[i]
			if player_data.equipped[n]:
				itemstats[i] += player_data.equipped[n].stat_modifiers[i]
		fullstats[i] = player_data.stats[i] + itemstats[i]
		fullstats[i] += int(fullstats[i] * .5 * player_data.modifiers[i])
	return fullstats
		
