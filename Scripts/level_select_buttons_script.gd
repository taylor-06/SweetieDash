extends Control

@onready var levelNumber1ButtonsSFX = $Level1/ButtonSFX
@onready var levelNumber2ButtonsSFX = $Level2/ButtonSFX
@onready var levelNumber3ButtonsSFX = $Level3/ButtonSFX

func _on_level_1_pressed():
	levelNumber1ButtonsSFX.play()
	levelNumber1ButtonsSFX.connect("finished", Callable(self, "_on_audio_finished_level1"))

func _on_audio_finished_level1():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
	print("changed to level 1 scene")
	
func _on_level_2_pressed():
	levelNumber1ButtonsSFX.play()
	levelNumber1ButtonsSFX.connect("finished", Callable(self, "_on_audio_finished_level2"))

func _on_audio_finished_level2():
	get_tree().change_scene_to_file("res://Scenes/level_2.tscn")
	print("changed to level 2 scene")
	
func _on_level_3_pressed():
	levelNumber1ButtonsSFX.play()
	levelNumber1ButtonsSFX.connect("finished", Callable(self, "_on_audio_finished_level3"))

func _on_audio_finished_level3():
	get_tree().change_scene_to_file("res://Scenes/level_3.tscn")
	print("changed to level 3 scene")
