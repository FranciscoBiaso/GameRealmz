"""
Author: Francisco de Biaso Neto
email: kikinhobiaso@gmail.com

##################
### NodeAccess ###
##################

This module represents should implement all functions to get specific node.
"""
extends Node

# singletons #
class Get:
	static func __UI() -> Node:
		return UI

# instances #
func __MainScene() -> Node:
	return get_node("/root/Main")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

