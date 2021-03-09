extends Panel

var character = null#: GDScript = null
onready var nameLabel : Label = $CharnameLabel
onready var faceButton : Button = $PortraitButton

func _ready():
	pass

func set_character(chara) -> void :
#	print("charname : ", chara.charname)
	character = chara
	nameLabel.text = chara.name
	faceButton.icon = chara.portrait 
