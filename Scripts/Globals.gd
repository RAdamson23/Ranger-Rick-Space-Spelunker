extends Node

onready var isDead
onready var health = 6 setget set_health, get_health
onready var maxHealth = 6 setget set_maxHealth, get_maxHealth
onready var score = 0 setget set_score, get_score
onready var stamina = 5 setget set_stamina, get_stamina
onready var deathCount = 0
onready var current_planet = 1 setget set_current_planet, get_current_planet
onready var treasureCount = 0 setget set_treasureCount, get_treasureCount
var enemiesDefeated = 0
var planetsCompleted = 0
onready var baseLevel = "Level_01.tscn" setget set_baseLevel, get_baseLevel
onready var isInsidePlanet = false
onready var next_scene

onready var coinCount1 = 0
onready var coinCount2 = 0
onready var coinCount3 = 0
onready var coinBeen1 = false
onready var coinBeen2 = false
onready var coinBeen3 = false

func _ready():
	health = 6
	maxHealth = 6
	stamina = 5
	treasureCount = 0
	enemiesDefeated = 0
	coinCount1 = 0
	coinCount2 = 0
	coinCount3 = 0
	isDead = false
	randomize()

signal pauseGame

func scoreCalc():
	var scoreCalc = (score+(enemiesDefeated*5)+(deathCount*-20))
	return scoreCalc

func onDeath():
	get_tree().change_scene(baseLevel)
	_ready()
	deathCount+=1

func next_level():
	deathCount = 0
	get_tree().change_scene(next_scene)

func _physics_process(delta):
	#print(current_planet 	)
	pass

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
