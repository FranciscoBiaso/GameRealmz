"""
Author: Francisco de Biaso Neto
email: kikinhobiaso@gmail.com

#####################
### Player Module ###
#####################

This module represents a player character.
"""

extends Area2D

func _ready():	
	# Player start Layer #
	z_index = 4

# Game inputs #
func _input(event):
	if event is InputEventKey and event.pressed:
		if event is InputEventKey and event.scancode == KEY_UP:
			position.y -= Utils.GRID_SIZE
		elif event is InputEventKey and event.scancode == KEY_DOWN:
			position.y += Utils.GRID_SIZE
		elif event is InputEventKey and event.scancode == KEY_RIGHT:
			position.x += Utils.GRID_SIZE
		elif event is InputEventKey and event.scancode == KEY_LEFT:
			position.x -= Utils.GRID_SIZE

func _process(delta):
	pass

func on_thing_enter():
	pass

func on_thing_leave():
	pass
