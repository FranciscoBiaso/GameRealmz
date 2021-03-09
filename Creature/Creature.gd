extends Object
#Only custom classes that inherit from Object or another class can be extended (have child classes)

# Declare member variables here. Examples:
var name : String = 'Base Creature'

var aiPackage : GDScript = null

var position : Vector2 = Vector2.ZERO # in tiles, coordinates should be positive integers. 0,0 = top left of map.
var size : Vector2 = Vector2.ONE
var dirfaced : int = 1  #  <0  is left, >0 is right
var selected : bool = false
var textureL : Texture = null #the image for the creature, facing left
var textureR : Texture = null # the image for the creature facing right
#if after initialization  TextureR is null, it will be just a horizontally flipped version of textureL


var baseFaction : int = 1 #0= allies of player. 1=Enemy, 2=Neutral. More faction ally/enemy relations can be defined in scenario data.
var curFaction : int = baseFaction # if a creature is attacked by its friends  or Charmed by another faction, they may temporarily switch sides and help another faction.

var level : int = 1 # Except for Players, this is only indicative of a Creature's power

var abilities : Array = [] #Melee attack, magic, items etc
var inventory : Array = [] # items worn/carried and usable/dropped by this creature


var innateEffects : Array = []   # Array of objets of class "StatusEffect"
var equipmentEffects : Array = []
var temporaryEffects : Array = []

## Base Stats ! (only for Player Characters ... )
#var baseStrength : int = 12 # unmodified. Affects melee damage and accuracy, possibly weapon AP costs, weiight limit, etc.
#var baseVitality : int = 12 # affects curMaxHP and curHPRegen
#var baseAgility : int = 12 # unmodified. Affects speed, dodge% and  all accuracy ( a bit).
#var baseIntellect : int = 12  # affects effectiveness of Magic and some items, and magic resistance
#var baseSpirit : int = 12 # affects efectiveness of priest magic and MP regeneration
#var maxWeight : int = 10000
#var curWeight : int = 0

var baseSpeed : int = 12 # affects turn order 
var meleeDamageBonus : int = 0
var rangedDamageBonus : int = 0
var magicDamageBonus : int = 0

# HP= Health Points. When HP<0,  the character is unconscious , is removed from battle and starts bleeding. At (-10? -Max(10,Level) ?) the character is dead.
var basemaxHP : int = 5 #the maximum  Health Points this creature can have
var curHP : int = basemaxHP
var baseregenHP : int = 0  # unmodified by equipment etc, automatically  regenerated HP at the end of turn... if curHP>0 !

# SP are the ressource  used for casting magic or using some magic items, recharging Magic Items, etc.
var basemaxSP : int = 5 # unmodified by status or equipment
var curSP : int = basemaxSP
var baseregenSP : int = 0
#var currregenSP : int = baseregenSP

# Attack Points =  How many actions (not movement)  a character can do during its battle round. All actions (attack magic item) cost AP.
var basemaxAP : int = 10  #This character's max Action Points, before modifications by status or equipment or weight
var curAP : int = basemaxAP
var baseregenAP : int = basemaxAP # before modifications by equipment and status AP regenerated at the end of the turn, up to a max  of MaxAP

# Movement Points. Moving accross terrain costs MP, cost varies with  the definition and character status (flying, etc)
var basemaxMP : int = 10  #This character's max Movement  Points, before modifications by status or equipment or weight
var curMP : int = basemaxMP
var baseregenMP : int = basemaxMP # before modifications by equipment and status MP regenerated at the end of the turn, up to a max  of MaxAP


var basePhysicalDmgReduction : int = 0  #  phyical (sword bow..)  damage is reduced by this amount.
var baseMeleeEvasion : int = 10 # skill at dodging melee physical attacks
var baseRangedEvasion : int = 10 # skill at dodging ranged physical attacks (bow etc)
var baseMagicDmgReduction : int = 0 # all magic based damage is reduced by this amount
var baseMagicEvasion : int = 10 # skill at evading any non AOE offensive magic

var baseFireDmgReduction : int = 0
var baseColdDmgReduction : int = 0
var baseElecDmgReduction : int = 0
var baseArcaneDmgReduction : int = 0 # "non elemental"  magic
var baseMentalDmgReduction : int = 0 # psychic effects
var baseChemicalDmgReduction : int = 0  # acid etc
var baseBiologicDmgReduction : int = 0 # Poison, Disease...

# same but percentage based .  <0 = weakness,  >0 = resistance, >100= healed
var baseFireDmgResistance : int = 0
var baseColdDmgResistance : int = 0
var baseElecDmgResistance : int = 0
var baseArcaneDmgResistance : int = 0
var baseMentalDmgResistance : int = 0
var baseChemicalDmgResistance : int = 0
var baseBiologicDmgResistance : int = 0

var traits : Array = [] # Reptilian, Humanoid, Undead, Intelligent etc
var racialBonuses : Dictionary = {}  # entries are  race : String, bonus : int 


func set_textures(lefttext : Texture, righttext : Texture = null)->void :
	textureL = lefttext
	if righttext == null :
		var  img = lefttext.get_data().flip_x()
		textureR = ImageTexture.new()
		textureR.create_from_image(img,0)
	else :
		textureR = righttext

func move(dir : Vector2)->void :
	position += dir

func move_to(newpos : Vector2)->void :
	position = newpos

func get_effects()->Array :
	var alleffects : Array = []
	for e in innateEffects :
		alleffects.append({e : innateEffects[e]} )
	for e in equipmentEffects :
		alleffects.append({e : innateEffects[e]})
	for e in temporaryEffects :
		alleffects.append({e : innateEffects[e]})
	return alleffects

func get_mp_cost_for_tile(tile : Dictionary)->int : #<0 means not walkable
	var walkeffects : Array = []
	for e in get_effects() :
		if e.has_method("_on_walking_on_item") :
			walkeffects.append(e)
	var cost : float = 0
	for e in walkeffects :
		for i in tile["items"] :
			if i.is_wall :
				return -1
	#		var icost = 0
			var icostfromeffect = e._on_walking_on_item(i)
			if icostfromeffect[1] :  #should return now
				return int(max(0, icostfromeffect[0]))
			else :
				cost += icostfromeffect[0]
	return int(min(cost,1))

		

# Called when the node enters the scene tree for the first time.
func _ready():
	print("wow i actually  can use a  ready function")
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
