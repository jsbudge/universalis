extends Resource

class_name PlayerData

@export var inventory: InventoryDatabase
@export var hp = 100
@export var equipped: Array[Equipment]
@export var ready_orbs: Array[Orb]
@export var stats: Array[int]
@export var modifiers: Array[float]
@export var gold: int
@export var shards: int
@export var active_orb: int = 0
