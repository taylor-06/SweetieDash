extends Node

var save_path = "user://savegamedata.txt"

@onready var player = $Player
@onready var livesIMG = $UI_Elements/Lives_UI/Lives
@onready var deathMenu = $UI_Elements/Death_Menu
@onready var winMenu = $UI_Elements/Win_Screen
@onready var level_timer = $LevelTimer/LevelTimer
@onready var player_camera = $Player/CharacterBody2D/Camera2D

@onready var winSFX = $Win_SFX
@onready var loseSFX = $Lose_SFX

var winSFXIsPlaying = false
var loseSFXIsPlaying = false

@export var target_score = 10

@export var level_wait_time = 60

var l1_time_high_score:float
var l1_time_score:float

var l2_time_high_score:float
var l2_time_score:float

var l3_time_high_score:float
var l3_time_score:float

var gameWon = false


func _ready():
	load_data()
	
	if is_in_group("level1"):
		player_camera.limit_right = 1280
	
	if is_in_group("level2"):
		player_camera.limit_right = 1280 * 2
		
	if is_in_group("level3"):
		player_camera.limit_right = 1280 * 4
		target_score = 20

	

func _process(delta):
	if !player:
		return
	
	if Input.is_action_just_pressed("kill"):
		player.lives = player.lives - 5
		print("Dude:'I regret nothing'")
	
	if player.score >= target_score:
		gameWon = true
		
	if gameWon:
		if !winSFXIsPlaying:
			winSFX.play()
			if winSFX.finished:
				winSFXIsPlaying = true
		player.canTakeDamage = false
		winMenu.show()
		if is_in_group("level1"):
			l1_time_score = level_timer.time_left
			if l1_time_score > l1_time_high_score:
				l1_time_high_score = l1_time_score
				print(l1_time_high_score)
				save_data()
		
		if is_in_group("level2"):
			l2_time_score = level_timer.time_left
			if l2_time_score > l2_time_high_score:
				l2_time_high_score = l2_time_score
				print(l2_time_high_score)
				save_data()
		
		if is_in_group("level3"):
			l3_time_score = level_timer.time_left
			if l3_time_score > l3_time_high_score:
				l3_time_high_score = l3_time_score
				print(l3_time_high_score)
				save_data()

	if player.dead == true:
		if !loseSFXIsPlaying:
			loseSFX.play()
		if loseSFX.finished:
			loseSFXIsPlaying = true
		deathMenu.show()
		player.playerDeath()
		level_timer.stop()
	
	if get_node("UI_Elements/ESC_Menu").is_visible():
		player.process_mode = PROCESS_MODE_DISABLED
		level_timer.paused = true
	else:
		player.process_mode = PROCESS_MODE_INHERIT
		level_timer.paused = false
		
	if player.lives == 3:
		livesIMG.texture = load("res://Assets/UI/Hearts/3_Lives_UI.png")
	elif player.lives == 2:
		livesIMG.texture = load("res://Assets/UI/Hearts/2_Lives_UI.png")
	elif player.lives == 1:
		livesIMG.texture = load("res://Assets/UI/Hearts/1_Lives_UI.png")
	else:
		livesIMG.texture = load("res://Assets/UI/Hearts/0_Lives_UI.png")

func _on_button_pressed():
	player.lives = player.lives - 1
	print("Player has ", player.lives, " lives left.")
	
func save_data():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(l1_time_high_score)
	file.store_var(l2_time_high_score)
	file.store_var(l3_time_high_score)
	print("data has been saved")

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		l1_time_high_score = file.get_var(l1_time_high_score)
		l2_time_high_score = file.get_var(l2_time_high_score)
		l3_time_high_score = file.get_var(l3_time_high_score)
		print("loaded data: 
			\n l1 = " + str(l1_time_high_score) + "
			\n l2 = " + str(l2_time_high_score) + "
			\n l3 = " + str(l3_time_high_score))
	else:
		print("no data has been loaded")
		l1_time_high_score = 0
		l2_time_high_score = 0
		l3_time_high_score = 0
