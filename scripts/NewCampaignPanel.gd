extends Panel

onready var campaignsItemList : ItemList = $CampaignsItemList
onready var charactersItemList : ItemList = $CharactersItemList
onready var pickedcharsItemList : ItemList = $PickedCharactersItemList
onready var cancelButton : Button = $CancelButton
onready var addButton : Button = $AddButton
onready var rmvButton : Button = $RemoveButton
onready var startButton : Button = $StartButton

var campaignslist : Array = [] # array of Strings
var characterfoldernameslist : Array = [] # array of String
var characterslist : Array = [] # array of Character.gd objects
var charactersdict : Dictionary = {}  #  name : characterGD


var selectedCampaign : String = ''

var selectedFreeCharIndex : int = -1
var selectedPickedCharIndex : int = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	cancelButton.connect("pressed", self, "_on_CancelButton_pressed")
	campaignsItemList.connect("item_selected", self, "_on_campaign_selected")
#	campaignsItemList.connect("nothing_selected", self, "_on_campaign_unselected")
	charactersItemList.connect("item_selected", self, "_on_freeChara_selected")
	charactersItemList.connect("item_activated", self, "_on_freeChara_activated")
	charactersItemList.connect("nothing_selected", self, "_on_freeChara_unselected")
	pickedcharsItemList.connect("item_selected", self, "_on_pickedChara_selected")
	pickedcharsItemList.connect("item_activated", self, "_on_pickedChara_activated")
	pickedcharsItemList.connect("nothing_selected", self, "_on_pickedChara_unselected")
	addButton.connect("pressed", self, "_on_AddButton_pressed")
	rmvButton.connect("pressed", self, "_on_RmvButton_pressed")
	startButton.connect("pressed", self, "_on_StartButton_pressed")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_CancelButton_pressed() -> void :
	self.hide()
	self.get_parent().get_parent().newCharacterButton.show()

func _on_campaign_selected(idx : int) -> void :
#	print(idx, campaignsItemList.get_item_text(idx))
	selectedCampaign = campaignsItemList.get_item_text(idx)
	$SelectedCampaignNameLabel.text = selectedCampaign
	if pickedcharsItemList.get_item_count() > 0 :
		startButton.disabled = false


func _on_freeChara_selected(index : int) -> void :
	selectedFreeCharIndex = index

func _on_freeChara_unselected() -> void :
	selectedFreeCharIndex = -1

func _on_freeChara_activated(index : int) -> void :
	print("_on_freeChara_activated display info on ",index)

func _on_pickedChara_selected(index : int) -> void :
	selectedPickedCharIndex = index

func _on_pickedChara_unselected() -> void :
	selectedPickedCharIndex = -1

func _on_pickedChara_activated(index : int) -> void :
	print("_on_pickedChara_activated display info on",index)

func _on_AddButton_pressed() -> void :
	if selectedFreeCharIndex<0 :
		return
	pickedcharsItemList.add_item(charactersItemList.get_item_text(selectedFreeCharIndex), charactersItemList.get_item_icon(selectedFreeCharIndex))
	charactersItemList.remove_item(selectedFreeCharIndex)
	charactersItemList.unselect_all()
	if selectedCampaign!='' :
		startButton.disabled = false


func _on_RmvButton_pressed() -> void :
	if selectedPickedCharIndex<0 :
		return
	charactersItemList.add_item(pickedcharsItemList.get_item_text(selectedPickedCharIndex), pickedcharsItemList.get_item_icon(selectedPickedCharIndex))
	pickedcharsItemList.remove_item(selectedPickedCharIndex)
	pickedcharsItemList.unselect_all()
	if selectedCampaign!='' and pickedcharsItemList.get_item_count() > 0 :
		startButton.disabled = false
	else :
		startButton.disabled = true

func _on_StartButton_pressed() -> void :
	var howmany =  pickedcharsItemList.get_item_count()
	if howmany == 0 or howmany > 6 :
		return
	##TODO  also check scenario restrictions !
	var pickedCharactersNames : Array = []
	for p in range(howmany) :
		pickedCharactersNames.append(pickedcharsItemList.get_item_text(p))
	var pickedCharacters : Array = []
	for p in pickedCharactersNames :
		pickedCharacters.append(charactersdict[p])	
	GameGlobal.hideAllUI()
	GameGlobal.setupDefaultUI(pickedCharacters)
	#get_tree().get_root().remove_child(get_parent().get_parent().get_parent())

func fill() -> void :
	campaignslist = Utils.FileHandler.list_files_in_directory(Paths.campaignsfolderpath)
	campaignsItemList.clear()
	charactersItemList.clear()
	for c in campaignslist :
		campaignsItemList.add_item(c)

	characterslist = []
	charactersdict = {}
	characterfoldernameslist = Utils.FileHandler.list_files_in_directory(Paths.profilesfolderpath+"/"+Paths.currentProfileFolderName+"/Characters/")
	for c in characterfoldernameslist :
		var path = Paths.profilesfolderpath+Paths.currentProfileFolderName+'/Characters/'+c
		print("charpath : ",path)
		var newchar = Utils.FileHandler.load_character(path)
		characterslist.append(newchar)
		charactersdict[newchar.name] = newchar
	for c in characterslist :
#		var nametext : String = c.charname
#		if not c.availlable :
#			nametext = nametext + " (busy)"
		charactersItemList.add_item(c.name, c.portrait)#, c.availlable)
#	print("characters : ",characterlist)
