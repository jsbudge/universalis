extends Resource

class_name Move

@export var name: String = "Move"
@export var description: String = "Base move class"
@export var icon: Texture
@export var _type: int = 0
@export var range: int = 1
@export var area_of_effect: int = 1
@export var cost: Array[int] = [0, 0, 0, 0, 0, 0]
@export var hook: int = -1
@export var power: int = 0
@export var tech: int = 0
@export var harmonics: Array[int] = [0, 0, 0, 0, 0]

