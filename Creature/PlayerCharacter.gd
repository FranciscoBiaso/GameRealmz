extends 'res://Creature/Creature.gd' # Weird, right?



var portrait : Texture = null


func _init(new_name:String, new_availlable : bool, new_portrait : ImageTexture):
	name = new_name
	portrait = new_portrait
#	var path = ProjectSettings.globalize_path("res://")
#
#	var img = Image.new()
#	var err = img.load(path+"Data/Profiles/"+profile+"/Characters/"+new_name+"/portrait.png")
#	if (err!=0) :
#		print("error loading image at "+path+"Data/Profiles/"+profile+"/Characters/"+new_name+"/portrait.png")
#		return null
#
#	portrait = ImageTexture.new()
#	portrait.create_from_image(img)
