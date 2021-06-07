extends Node

onready var isDead
onready var health = 6 setget set_health, get_health
onready var maxHealth = 6 setget set_maxHealth, get_maxHealth
onready var score = 0 setget set_score, get_score
onready var stamina = 5 setget set_stamina, get_stamina
onready var deathCount = 0
onready var current_planet = 1 setget set_current_planet, get_current_planet
onready var treasureCount = 0 setget set_treasureCount, get_treasureCount
onready var Planet4HUDUpdater = 1
var enemiesDefeated = 0
var planetsCompleted = 0
onready var baseLevel = "Level_01.tscn" setget set_baseLevel, get_baseLevel
onready var respawnLevel = "CaveInterior1.tscn"
onready var isInsidePlanet = false
onready var next_scene

onready var coinCount1 = 0
onready var coinCount2 = 0
onready var coinCount3 = 0
onready var coinBeen1 = false setget set_coinBeen1, get_coinBeen1
onready var coinBeen2 = false setget set_coinBeen2, get_coinBeen2
onready var coinBeen3 = false setget set_coinBeen3, get_coinBeen3

func _ready():
	health = 8
	maxHealth = 8
	stamina = 5
	treasureCount = 0
	coinCount1 = 0
	coinBeen1 = false
	coinCount2 = 0
	coinBeen2 = false
	coinCount3 = 0
	coinBeen3 = false
	isDead = false
	randomize()

func resetHealthStaminaAndTreasureCount():
	health = 8
	stamina = 5
	treasureCount = 0
	coinCount1 = 0
	coinCount2 = 0
	coinCount3 = 0

func scoreCalc():
	var scoreCalc = (score+(enemiesDefeated*5)+(deathCount*-20))
	return scoreCalc

func onDeath():
	if !isInsidePlanet:
		get_tree().change_scene("res://Levels/"+baseLevel)
	else:
		get_tree().change_scene("res://Levels/"+respawnLevel)
	resetHealthStaminaAndTreasureCount()
	deathCount+=1

func next_level():
	deathCount = 0
	enemiesDefeated = 0
	get_tree().change_scene(next_scene)

func set_baseLevel(value):
	baseLevel = value
	pass
func get_baseLevel():
	return baseLevel

func set_treasureCount(value):
	treasureCount = value
	pass
func get_treasureCount():
	return treasureCount

func set_current_planet(value):
	current_planet = value
	pass
func get_current_planet():
	return current_planet
func set_health(value):
	health = value
	pass
func get_health():
	return health
func set_maxHealth(value):
	maxHealth = value
	pass
func get_maxHealth():
	return maxHealth
func set_score(value):
	score = value
	pass
func get_score():
	return score	
func set_stamina(value):
	stamina = value
	pass
func get_stamina():
	return stamina
	
	
	
func set_coinBeen1(value):
	coinBeen1 = value
	pass
func get_coinBeen1():
	return coinBeen1
func set_coinBeen2(value):
	coinBeen2 = value
	pass
func get_coinBeen2():
	return coinBeen2
func set_coinBeen3(value):
	coinBeen3 = value
	pass
func get_coinBeen3():
	return coinBeen3
	
	
