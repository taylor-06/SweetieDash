extends CanvasLayer

@onready var level_timer = $LevelTimer
@onready var timer_text = $TimerText
@onready var level = $/root/Level
@onready var player = $/root/Level/Player
@onready var deathMenu = $/root/Level/UI_Elements/Death_Menu
@onready var loseSFX = $/root/Level/Lose_SFX

var loseSFXIsPlaying = false

# Called when the node enters the scene tree for the first time.
func _ready():
	level_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var time = str(level_timer.time_left)
	var timeRounded = snapped(float(time), 0.1)
	timer_text.text = "Time Left: " + str(timeRounded)
	
	if !player:
		return
	
	if player.dead:
		return
	
	if level_timer.time_left == 0 and player.score != level.target_score:
		if !loseSFXIsPlaying:
			loseSFX.play()
		if loseSFX.finished:
			loseSFXIsPlaying = true
		level.gameWon = false
		deathMenu.show()
	
	if player.score == level.target_score and level_timer.time_left > 0:
		level.gameWon = true
		level_timer.paused = true
