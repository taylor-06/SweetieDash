extends Node2D

@onready var player = get_node("/root/Level/Player")
@onready var score_label = get_node("/root/Level/UI_Elements/Score/Label")
@onready var level = get_node("/root/Level/")
@onready var level_timer = get_node("/root/Level/LevelTimer/LevelTimer")
@onready var collectSFX = $CollectSFX

@export var score_add = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	if level.is_in_group("levdel3"):
		score_label.text = "Score: 0 / 20"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		if player.score >= level.target_score:
			return
		if level_timer.time_left <= 0:
			return
		player.score = player.score + score_add
		collectSFX.play()
		if player.score >= 10:
			score_label.text = "Score: " + str(player.score) + " / " + str(level.target_score)
		else:
			score_label.text = "Score: 0" + str(player.score) + " / " + str(level.target_score)
		print("score is now: " + str(player.score))
		
		collectSFX.connect("finished", Callable(self, "_on_audio_finished_collect"))

func _on_audio_finished_collect():
	queue_free()
