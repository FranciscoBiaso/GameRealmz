extends Node2D

var charsmallpanelTSCN : PackedScene = preload("res://scenes/CharacterSmallPanel.tscn")
var characters : Array =  []

onready var charsVContainer : VBoxContainer = $CanvasLayer/VBoxContainer

func initialize(ncharacters : Array) : # takes an array of Characters GD class objects !
#	for c in ncharacters :
#		print(c.charname)
	characters = ncharacters


# Called when the node enters the scene tree for the first time.
func _ready():
#	var i : int = 0
	for c  in characters :
		var charpanel = charsmallpanelTSCN.instance()
		charsVContainer.add_child(charpanel)
#		charpanel._set_global_position(Vector2(0,300*i) )
		charpanel.set_character(c)
#		print(c.charname)
#		i +=1
#	print(characters[0].charname)

