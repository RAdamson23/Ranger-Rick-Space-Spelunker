extends Node

var isInPlanet = true setget set_isInPlanet, get_isInPlanet
onready var isDead
onready var health = 6 setget set_health, get_health
onready var maxHealth = 6 setget set_maxHealth, get_maxHealth
onready var score = 0 setget set_score, get_score
onready var stamina = 5 setget set_stamina, get_stamina
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_isInPlanet(value):
	isInPlanet = value
	pass

func get_isInPlanet():
	return isInPlanet
	pass

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
