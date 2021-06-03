extends Node

onready var isDead
onready var health = 6 setget set_health, get_health
onready var maxHealth = 6 setget set_maxHealth, get_maxHealth
onready var score = 0 setget set_score, get_score
onready var stamina = 5 setget set_stamina, get_stamina
onready var deathCount = 0
onready var current_planet = 1 setget set_current_planet, get_current_planet
onready var mainCollectable = 0 setget set_mainCollectable, get_mainCollectable
var enemiesDefeated = 0

func _ready():
	health = 6
	maxHealth = 6
	stamina = 5
	mainCollectable = 0
	enemiesDefeated = 0
	isDead = false
	randomize()

signal pauseGame

func onDeath():
	get_tree().change_scene("res://Levels/CaveInterior1.tscn")
	_ready()
	deathCount+=1


func _physics_process(delta):
	#print(current_planet 	)
	pass


func set_mainCollectable(value):
	mainCollectable = value
	pass
func get_mainCollectable():
	return mainCollectable
	

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
