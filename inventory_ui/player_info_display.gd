extends Control

@export var display_type: int = 3
@onready var sbox: VBoxContainer = $StatDisplay

# Called when the node enters the scene tree for the first time.
func _ready():
	updateItemDisplay(0)
	updateStatDisplay()
		
func updateStatDisplay():
	for child in $StatDisplay.get_children():
		child.queue_free()
	var stat_names = ['Atk', 'Tech', 'Armor', 'Def', 'Spd']
	var pstats = ActivePlayer.getModStats()
	
	for idx in range(5):
		var statlabel = Label.new()
		statlabel.text = "%s: %d" % [stat_names[idx], pstats[idx]]
		$StatDisplay.add_child(statlabel)
		

func updateItemDisplay(tab):
	# Clear all the display stuff
	for child in get_children():
		if is_instance_of(child, TextureRect):
			child.texture = TextureRect.new()
		elif is_instance_of(child, Label):
			child.text = ""
	if tab < 2:
		display_type = tab + 3
	# Set all the proper display things for the display_type
	var disp_array = ActivePlayer.getArray(display_type)
	if disp_array[0]:
		%Item0.texture = disp_array[0].texture
		%Label0.text = disp_array[0].name
	if disp_array[1]:
		%Item1.texture = disp_array[1].texture
		%Label1.text = disp_array[1].name
	if disp_array[2]:
		%Item2.texture = disp_array[2].texture
		%Label2.text = disp_array[2].name
	if disp_array[3]:
		%Item3.texture = disp_array[3].texture
		%Label3.text = disp_array[3].name
	if disp_array[4]:
		%Item4.texture = disp_array[4].texture
		%Label4.text = disp_array[4].name


func _on_tab_bar_tab_changed(tab):
	updateItemDisplay(tab)
	updateStatDisplay()
