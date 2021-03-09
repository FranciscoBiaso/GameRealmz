"""
Author: Francisco de Biaso Neto
email: kikinhobiaso@gmail.com

#####################
### Pathjs Module ###
#####################

This module contains constantes to all important paths used into this project.
"""
extends Node

const MYFILENAME = "Realmz/"
var profilesfolderpath : String = ''
var realmzfolderpath : String = ''
var campaignsfolderpath : String = ''
var datafolderpath : String = ''

var thingtypes : Dictionary = {}
var tiles_stuffbook : Dictionary = {}

var currentProfileFolderName : String = "Default Profile"

func _ready():
	profilesfolderpath = realmzfolderpath + "Profiles/"
	realmzfolderpath = ProjectSettings.globalize_path("res://")
	realmzfolderpath = realmzfolderpath.trim_suffix(MYFILENAME)
	profilesfolderpath = realmzfolderpath + "Profiles/"
	campaignsfolderpath = realmzfolderpath + "Campaigns/"
	datafolderpath = realmzfolderpath + "Data/"
	currentProfileFolderName = Utils.FileHandler.get_cfg_setting("SETTINGS","current_profile", "Default Profile")
