extends Resource
class_name SlotData

const MAX_STACK_SIZE: int = 99
@export_range(1, MAX_STACK_SIZE) var quantity: int = 1
var is_stackable: bool = false
