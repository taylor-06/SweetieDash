extends TextureButton

@onready var playButton = $TextureButton

func _on_pressed():
	get_tree().change_scene("res://Scenes/level_1.tscn")
	print("changed scene")
