extends Node2D

@onready var timer = $Timer
@onready var player = get_node("/root/Level/Player")
@onready var player_body = get_node("/root/Level/Player/CharacterBody2D")
@onready var animatedSprite = $/root/Level/Player/CharacterBody2D/AnimatedSprite2D

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		if player.canTakeDamage:
			if timer.time_left > 0:
				print("player in damage cooldown.")
				return
			else:
				player.lives = player.lives - 1
				damage_player()
				player.damageSFX.play()
				player_body.damage_bounce(-0.5)
				timer.start()
				print("Player has ", player.lives, " lives left")
		else:
			return
			
func damage_player():
	if player.compare_lives != player.lives:
		player.damage_timer.start()
		print("damage timer started")
		player.animatedSprite.play("damage_right")
