extends CanvasLayer

@onready var level = get_node("/root/Level")
@onready var high_score_text = $TextureRect/HighScoreText

@onready var backButtonSFX = $TextureRect/Back_Button/ButtonSFX
@onready var levelSelectButtonSFX = $TextureRect/Level_Select_Button/ButtonSFX
@onready var helpButtonSFX = $TextureRect/Help_Button/ButtonSFX

func _process(delta):
	if Input.is_action_just_pressed("esc"):
		get_node(".").show()

	if is_in_group("level1"):
		var l1_time_high_score = str(level.l1_time_high_score)
		var l1_timeRounded = snapped(float(l1_time_high_score), 0.1)
		high_score_text.text = "High Score: " + str(l1_timeRounded) + " Seconds Left"
		
	if is_in_group("level2"):
		var l2_time_high_score = str(level.l2_time_high_score)
		var l2_timeRounded = snapped(float(l2_time_high_score), 0.1)
		high_score_text.text = "High Score: " + str(l2_timeRounded) + " Seconds Left"
	
	if is_in_group("level3"):
		var l3_time_high_score = str(level.l3_time_high_score)
		var l3_timeRounded = snapped(float(l3_time_high_score), 0.1)
		high_score_text.text = "High Score: " + str(l3_timeRounded) + " Seconds Left"

func _on_back_button_pressed():
	backButtonSFX.play()
	backButtonSFX.connect("finished", Callable(self, "_on_audio_finished_back"))
	
func _on_audio_finished_back():
	get_node(".").hide()

func _on_level_select_button_pressed():
	levelSelectButtonSFX.play()
	levelSelectButtonSFX.connect("finished", Callable(self, "_on_audio_finished_level"))
	
func _on_audio_finished_level():
	get_tree().change_scene_to_file("res://Scenes/level_select.tscn")
	print("changed to level select scene")

func _on_help_button_pressed():
	helpButtonSFX.play()
	helpButtonSFX.connect("finished", Callable(self, "_on_audio_finished_help"))

func _on_audio_finished_help():
	get_tree().change_scene_to_file("res://Scenes/help_menu.tscn")
	print("changed to level select scene")
