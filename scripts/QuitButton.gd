extends Button

func _ready():	
	connect("pressed", self, "_on_Button_pressed")

func _on_Button_pressed() :
	print("QUITTING GAME")
	# http://docs.godotengine.org/en/latest/tutorials/misc/handling_quit_requests.html
	get_tree().quit()
