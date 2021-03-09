"""
Author: Francisco de Biaso Neto
email: kikinhobiaso@gmail.com

##################
### Map Module ###
##################

Loads Things and add them into this Node.
"""

extends Node

# Get Thing Scene By default #
export (PackedScene) var _thing

# Call functions to load the map #
func _ready():
	load_map()

# Load the game map #
func load_map() -> void:
	var resources = get_node("../Resources")	
	# Iterate through each map unity (json) #
	for things in resources.get_map_things()["map_units"]:
		# Iterate through each thing name into this unity #
		for thing_name in things["items"]:
			# Get img ref #
			var img_ref = resources.get_stuff_book()[thing_name]["img_ptr"]
			# Get thing type (structure, floor, etc) #
			var thing_type = resources.get_stuff_book()[thing_name]["type"]
			# Get x,y position #
			var obj_position = Vector2(things["x"]* Utils.GRID_SIZE,things["y"] * Utils.GRID_SIZE)
			# Get position into texture atlas #
			var rect = Rect2(resources.get_img_pack()[img_ref]["0_ref_x"] * Utils.GRID_SIZE,resources.get_img_pack()[img_ref]["0_ref_y"] * Utils.GRID_SIZE,Utils.GRID_SIZE,Utils.GRID_SIZE)
			# Create a new texture for this thing #
			var texture = ImageTexture.new()
			# Loads texture from texture atlas #
			texture.create_from_image(resources.get_texture_atlas().get_rect(rect),0)
			# Instantiate the Thing #
			var thing = _thing.instance().new(obj_position,texture)
			# Add layer #
			var z_order = 0
			for i in resources.get_thing_types()["types"]:
				if i["name"] == thing_type:
					z_order = i["layer"]
				# Connect thing singal to player (used by scripts) #
				if thing_type == "ground":
					thing.connect("on_thing_enter", get_parent().get_node("Player"), "on_thing_enter")
					thing.connect("on_thing_leave", get_parent().get_node("Player"), "on_thing_leave")
			thing.z_index = definition.Render.LAYERS.GAME + z_order
			add_child(thing)
