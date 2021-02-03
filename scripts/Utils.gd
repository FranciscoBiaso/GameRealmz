"""
Author: Francisco de Biaso Neto
email: kikinhobiaso@gmail.com

####################
### Utils Module ###
####################

This module contains auxiliary functions and constantes.
"""

extends Node

class_name Utils

# Constant #
const GRID_SIZE := 32

# File manipulator #
class FileHandler:
	static func read_json_array_from_txt(txt) -> Array:
		var data_parse = JSON.parse(txt)
		if data_parse.error != OK:
			return []
		return data_parse.result

	static func read_json_dictionary_from_txt(txt) -> Dictionary:
		var data_parse = JSON.parse(txt)
		if data_parse.error != OK:
			return {}
		return data_parse.result

	static func read_txt_from_file(path) -> String:
		var data_file = File.new()
		if data_file.open(path, File.READ) != OK:
			return ""
		var data_text = data_file.get_as_text()
		data_file.close()
		return data_text
	

func _ready():
	pass
