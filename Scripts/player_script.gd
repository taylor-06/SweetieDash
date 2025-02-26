extends Node2D

@onready var animatedSprite = $CharacterBody2D/AnimatedSprite2D
@onready var damage_timer = $Damage_Timer
@onready var damageSFX = $CharacterBody2D/DamageSFX

var lives = 3
var compare_lives = 3
var dead = false
var score = 0

var canTakeDamage = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if lives <= 0:
		dead = true
	
	if compare_lives != lives:
		if damage_timer.time_left >= 0:
				animatedSprite.play("damage_right")

func playerDeath():
	if dead == true:
		queue_free()

func _on_damage_timer_timeout():
		compare_lives = lives
		animatedSprite.play("idle")
