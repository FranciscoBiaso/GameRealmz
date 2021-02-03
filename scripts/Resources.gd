"""
Author: Francisco de Biaso Neto
email: kikinhobiaso@gmail.com

#######################
### Resource Module ###
#######################

All resources are loaded and accessed through this module.
"""

extends Node

# Global resource variables #
var g_thing_types = {}
var g_stuff_book = {}
var g_img_pack = {}
var g_map_things = {}
var g_scripts = {}
var g_texture_atlas = Image.new()

# Initialize resources #
func _ready():
	load_map_resources()
	load_audios()

# Load map data #
func load_map_resources() -> void:	
	g_img_pack = Utils.FileHandler.read_json_dictionary_from_txt(Utils.FileHandler.read_txt_from_file("map/default/img_pack.json"))
	g_stuff_book = Utils.FileHandler.read_json_dictionary_from_txt(Utils.FileHandler.read_txt_from_file("map/default/stuff_book.json"))
	g_map_things = Utils.FileHandler.read_json_dictionary_from_txt(Utils.FileHandler.read_txt_from_file("map/default/map_things.json"))	
	g_scripts = Utils.FileHandler.read_json_dictionary_from_txt(Utils.FileHandler.read_txt_from_file("map/default/scripts.json"))		
	g_thing_types = Utils.FileHandler.read_json_dictionary_from_txt(Utils.FileHandler.read_txt_from_file("map/default/thing_types.json"))
	g_texture_atlas.load("map/default/textureAtlas.png")

# Load audios #
func load_audios() -> void:
	pass

""" Accessible resources """

# Img Pack
func get_img_pack() -> Dictionary:
	return g_img_pack

# Stuff Book
func get_stuff_book() -> Dictionary:
	return g_stuff_book

# Map things
func get_map_things() -> Dictionary:
	return g_map_things

# Thing types - Layers
func get_thing_types() -> Array:
	return g_thing_types

# Get texture Atlas #
func get_texture_atlas() -> Image:
	return g_texture_atlas
