extends Node

var save_path = "user://savegamedata.txt"

@onready var backButtonSFX = $Back_Button/ButtonSFX

@onready var l1ScoreText = $HighScores/L1Score
@onready var l2ScoreText = $HighScores/L2Score
@onready var l3ScoreText = $HighScores/L3Score

var l1_time_high_score:float
var l2_time_high_score:float
var l3_time_high_score:float

func _ready():
	load_data()
	
	var l1_timeRounded = snapped(float(l1_time_high_score), 0.1)
	var l2_timeRounded = snapped(float(l2_time_high_score), 0.1)
	var l3_timeRounded = snapped(float(l3_time_high_score), 0.1)
	
	l1ScoreText.text = "Level 1: " + str(l1_timeRounded) + "s"
	l2ScoreText.text = "Level 2: " + str(l2_timeRounded) + "s"
	l3ScoreText.text = "Level 3: " + str(l3_timeRounded) + "s"
	

func _on_back_button_pressed():
	backButtonSFX.play()
	backButtonSFX.connect("finished", Callable(self, "_on_audio_finished_back"))
	
func _on_audio_finished_back():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	print("changed to main menu scene")

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
