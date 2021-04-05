extends Node

""" 
	The game state module representing a finite state machine to control the 
	game.
	# the game states must be reshaped according to the game. See GameGlobal.gd #
"""

var _state
var _gameStateFileConfigs
func _ready():
	pass # Replace with function body.

# here will occur the game logic #
func update():
	if _state == GameGlobal.eGameStates.startGame :
		doStartGame()
		setState(GameGlobal.eGameStates.inGame)
	elif _state == GameGlobal.eGameStates.saveGame :
		doSaveGame()
		setState(GameGlobal.eGameStates.inGame)	
	elif _state == GameGlobal.eGameStates.inGame :	
		doInGame()
	elif _state == GameGlobal.eGameStates.endGame :	
		doEndGame()
	pass

func load(path : String):
	# load your json files with combat system config them add initiate those 
	# values.
	_gameStateFileConfigs = Utils.FileHandler.read_json_dic_from_file(path)	
	_state = _gameStateFileConfigs["state"]
	print("Game current state: [" + String(_state) + "]")
	pass

func save(path : String):
	print("Saving game state!")
	pass
	
func setState(state : int):
	_state = state

func doSaveGame():
	# save the game then return to inGame state #
	pass

func doStartGame():
	# -- #
	pass

func doEndGame():
	doSaveGame()
	pass
	
func doInGame():
	pass
