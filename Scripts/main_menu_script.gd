extends Node

@onready var playbuttonSFX = $BG/Play_Button/ButtonSFX
@onready var levelbuttonSFX = $BG/Level_Select_Button/ButtonSFX
@onready var helpbuttonSFX = $BG/Help_Button/ButtonSFX
@onready var versionTXT = $VersionText

@export var version:float = 0


func _ready():
	ProjectSettings.set_setting("application/config/version", str(version))
	versionTXT.text = "Version: " + ProjectSettings.get_setting("application/config/version")
	print("Version: " + ProjectSettings.get_setting("application/config/version"))

func _on_play_button_pressed():
	playbuttonSFX.play()
	playbuttonSFX.connect("finished", Callable(self, "_on_audio_finished_play"))

func _on_audio_finished_play():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
	print("changed to level 1 scene")
	
func _on_level_select_button_pressed():
	levelbuttonSFX.play()
	levelbuttonSFX.connect("finished", Callable(self, "_on_audio_finished_level"))
	
func _on_audio_finished_level():
	get_tree().change_scene_to_file("res://Scenes/level_select.tscn")
	print("changed to level select scene")

func _on_help_button_pressed():
	helpbuttonSFX.play()
	helpbuttonSFX.connect("finished", Callable(self, "_on_audio_finished_help"))

func _on_audio_finished_help():
	get_tree().change_scene_to_file("res://Scenes/help_menu.tscn")
	print("changed to level select scene")
