extends CanvasLayer

@onready var retryButtonSFX = $TextureRect/Retry_Button/Retry_Button_SFX
@onready var levelSelectButtonSFX = $TextureRect/Level_Select_Button/ButtonSFX

func _on_retry_button_pressed():
	retryButtonSFX.play()
	retryButtonSFX.connect("finished", Callable(self, "_on_audio_finished_retry"))
	
func _on_audio_finished_retry():
	get_tree().reload_current_scene()
	print("reloaded the scene")

func _on_level_select_button_pressed():
	levelSelectButtonSFX.play()
	levelSelectButtonSFX.connect("finished", Callable(self, "_on_audio_finished_level"))
	
func _on_audio_finished_level():
	get_tree().change_scene_to_file("res://Scenes/level_select.tscn")
	print("changed to level select scene")
