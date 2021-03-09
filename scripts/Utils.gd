"""
Author: Francisco de Biaso Neto
email: kikinhobiaso@gmail.com

####################
### Utils Module ###
####################

This module contains auxiliary functions and constantes.
"""
extends Node

# Constant #
const GRID_SIZE := 32

# File manipulator #
class FileHandler:
	static func read_json_array_from_txt(txt) -> Array:
		var data_parse = JSON.parse(txt)
		if data_parse.error != OK:
			return []
		return data_parse.result	
	
	static func read_json_dic_from_file(path) -> Dictionary:
		return read_json_dictionary_from_txt(read_txt_from_file(path))

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
		
	static func list_files_in_directory(path) -> Array :  #copied from profileslist.gd
		# from https://godotengine.org/qa/5175/how-to-get-all-the-files-inside-a-folder
		var files = []
		var dir = Directory.new()
		dir.open(path)
		dir.list_dir_begin()
		while true:
			var file = dir.get_next()
			if file == "":
				break
			elif not file.begins_with("."):
				files.append(file)
		dir.list_dir_end()
		return files
		
	static func get_cfg_setting(section, key, default) :
		var config = ConfigFile.new()
		var err = config.load(Paths.realmzfolderpath+"/settings.cfg")
		if err == OK: # if not, something went wrong with the file loading
			return config.get_value(section, key, default)	
	#	if not config.has_section_key(section, key):
	#			print(section, key)
		else :
			print("err",err)
				
	static func set_cfg_setting(section, key, value) :
		var config = ConfigFile.new()
		var err = config.load(Paths.realmzfolderpath+"/settings.cfg")
		if err == OK: # if not, something went wrong with the file loading
			# Look for the display/width pair, and default to 1024 if missing
	#		var screen_width = config.get_value("display", "width", 1024)
			# Store a variable if and only if it hasn't been defined yet
	#		if not config.has_section_key("audio", "mute"):
			config.set_value(section, key, value)
			print(key, value)
		else :
			print("err",err)
		# Save the changes by overwriting the previous file
		config.save(Paths.realmzfolderpath+"/settings.cfg")
	
	static func load_character(path)-> GDScript :		
		var img = Image.new()
		var err = img.load(path+"/portrait.png")
		if (err!=0) :
			print("error loading image at "+path+"/portrait.png")
	#		return null
		var newportrait = ImageTexture.new()
		newportrait.create_from_image(img)		
		var jsonresult = read_json_dic_from_file(path+'/data.json')		
		var newname = jsonresult['name']
		var newavaillable = jsonresult['free']		
		var newchar = GameGlobal.playerCharacterGD.new(newname, newavaillable, newportrait)
		return newchar
			
class Render:
	static func setAllChildrenLayers(nodeFather):
		if nodeFather == null:
			return
		for N in nodeFather.get_children():
			if N.get_child_count() > 0:  
				setAllChildrenLayers(N)
			else:			
				N.z_index = N.z_index + definition.Render.get_layer_space()		
				print(N.z_index)

func _ready() :
	pass
