extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var lineEdit : LineEdit = $LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "_on_Button_pressed")

func _on_Button_pressed()  -> void :
	var new_text = lineEdit.text
	if new_text == '' or new_text=="Profile Created !" :
		return
	var profilesfolderpath = GameGlobal.profilesfolderpath
	

	# http://docs.godotengine.org/en/latest/classes/class_lineedit.html#class-lineedit
	var dir = Directory.new()
	print("dir exists ? ",  dir.dir_exists(profilesfolderpath))
	if not dir.dir_exists(profilesfolderpath+"/" + new_text) :
		dir.make_dir_recursive(profilesfolderpath+"/" + new_text)
		dir.make_dir_recursive(profilesfolderpath+"/" + new_text +"/Characters/")
		dir.make_dir_recursive(profilesfolderpath+"/" + new_text +"/Saves/")
		print("created profile folder for"+new_text+" at " +profilesfolderpath + new_text)
		self.get_parent().set_current_profile(new_text)
		lineEdit.text = "Profile Created !"
		self.get_parent().build_profiles_list()
	else:
		print("This directory already exists !")
		lineEdit.text = "Profile already exists !"
		return
#	fill()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
