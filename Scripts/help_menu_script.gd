extends Node

@onready var backButtonSFX = $Back_Button/ButtonSFX
@onready var resetScoreButtonSFX = $Reset_Score_Button/ButtonSFX

var save_path = "user://savegamedata.txt"

func _on_back_button_pressed():
	backButtonSFX.play()
	backButtonSFX.connect("finished", Callable(self, "_on_audio_finished_back"))
	
func _on_audio_finished_back():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	print("changed to main menu scene")

func _on_reset_score_button_pressed() -> void:
	resetScoreButtonSFX.play()
	resetScoreButtonSFX.connect("finished", Callable(self, "_on_audio_finished_reset_score"))

func _on_audio_finished_reset_score():
	reset_saved_data();
	
func reset_saved_data():
	DirAccess.remove_absolute(save_path)
	print("reset saved data")
