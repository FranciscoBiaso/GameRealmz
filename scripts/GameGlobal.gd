"""
# Authors: Samuel Rebrearu , Francisco De Biaso Neto
# email: kikinhobiaso@gmail.com

##################
### GameGlobal ###
##################

This module is responsible for wrapper the game logic.
"""
extends Node

var playerCharacterGD : GDScript = preload("res://Creature/PlayerCharacter.gd")
var gameScreenTSCN : PackedScene = preload("res://scenes/GameScreenNode2D.tscn")
var gamescreenInstance

func _ready():
	pass
# UI start ------------------- #

# Hide all UI elements #
func hideAllUI():
	NodeAccess.Get.__UI().__hide()
# Setup the default UI #
func setupDefaultUI(pickedCharacters):
	gamescreenInstance = gameScreenTSCN.instance()
	gamescreenInstance.initialize(pickedCharacters)
	NodeAccess.__MainScene().add_child(gamescreenInstance)
# UI end ------------------- #
