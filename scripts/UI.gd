"""
Author: Francisco de Biaso Neto
email: kikinhobiaso@gmail.com

##########
### UI ###
##########

This module represents a user interface.
All operations over UI should use this wrapper.
"""
extends Node

func _ready():	
	pass

# Hide all user interface #
func __hide():
	# 0 is the root above canvasLayer #
	get_child(0).hide()
