extends Node

export var debug = false

onready var _combatSystem # child from main #
onready var _gameState # child from main #

func _ready():
	_gameState = get_node("CombatSystem") # access the child #
	_combatSystem = get_node("GameState") # access the child #
	# load all game modules.
	_combatSystem.load("configs/combatConfigs.json")	
	_gameState.load("configs/gameState.json")	
	pass # Replace with function body.

# THE MAIN LOOP GAME ARCHITECTURE #
func _process(delta: float):	
	# 1) process input (dont need to manipulate, godot is already doing) #
	# 2) game update #
	# --> access your classes and update them, if they have any logic, process:
	_combatSystem.update()
	_gameState.update()
	# 3) render (can be done automatic by godot) # 
	pass

func _exit_tree():
	_combatSystem.save("configs/combatConfigs.json")
	_gameState.save("configs/gameState.json")
	pass
