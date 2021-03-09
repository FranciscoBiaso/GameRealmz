extends Panel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var cancelButton : Button = $CancelButton
onready var okButton : Button = $OKButton
onready var lineEdit : LineEdit = $LineEdit
onready var nameLabel : Label = $NameLabel

#var onlyportrait : Texture = preload("res://Main Menu/onlyportrait.png")

var new_char_name = "[NO NAME]"
var dir = Directory.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	cancelButton.connect("pressed", self, "_on_CancelButton_pressed")
	okButton.connect("pressed", self, "_on_OKButton_pressed")
	lineEdit.connect("text_changed",self,"_on_LineEdit_changed")

func _on_CancelButton_pressed() -> void :
	self.hide()
	self.get_parent().get_parent().newCampaignButton.show()

func _on_OKButton_pressed() -> void :
	if new_char_name == "[NO NAME]" or new_char_name == "" :
		okButton.disabled = true
		return
	var save_char = File.new()
	var path = GameGlobal.profilesfolderpath+GameGlobal.currentProfileFolderName+'/Characters/'+new_char_name
	print("new char path : ", path)
	dir.make_dir_recursive(path)
	save_char.open(path+'/data.json', File.WRITE)
	save_char.store_line('{"name":"'+new_char_name+'", "free":1}')
	save_char.close()
	
	var img = Image.new()
	var err = img.load("res://Main Menu/onlyportrait.png")
	if (err!=0) :
		print("error loading image at "+path+"/portrait.png")
#		return null
	img.save_png(path+"/portrait.png")
	
	_on_CancelButton_pressed()

func _on_LineEdit_changed(newtext : String) -> void :
	new_char_name = newtext
	nameLabel.text = new_char_name
#	print(Autoloaded.profilesfolderpath+"/"+Autoloaded.currentProfileFolderName+"/Characters/"+new_char_name)
	if dir.dir_exists(GameGlobal.profilesfolderpath+"/"+GameGlobal.currentProfileFolderName+"/Characters/"+new_char_name) :
		nameLabel.set('custom_colors/font_color' , Color(1,0,0,1) )
		okButton.disabled = true
	else :
		nameLabel.set('custom_colors/font_color' , Color(0,1,0,1) )
		okButton.disabled = false

func fill() -> void :
	lineEdit.text = "[NO NAME]"
	new_char_name = "[NO NAME]"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
