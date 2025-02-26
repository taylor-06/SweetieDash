extends CharacterBody2D

@onready var animatedSprite = $AnimatedSprite2D
@onready var jumpingSFX = $JumpingSFX
@onready var walkingSFX = $WalkingSFX

const SPEED = 300.0
const JUMP_VELOCITY = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1350

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		animatedSprite.play("jump_right")

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jumpingSFX.play()

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	
	if is_on_floor() and direction == 0:
		animatedSprite.play("idle")

	if direction:
		velocity.x = direction * SPEED
		if Input.is_action_pressed("left"):
			if is_on_floor():
				animatedSprite.play("run_left")
			else:
				animatedSprite.play("jump_left")
		if Input.is_action_pressed("right"):
			if is_on_floor():
				animatedSprite.play("run_right")
			else:
				animatedSprite.play("jump_right")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func damage_bounce(delta):
	velocity.y += gravity * delta

func _on_animated_sprite_2d_frame_changed() -> void:
	if walkingSFX.is_playing():
		return
	
	if animatedSprite.animation == "damage_left" or "damage_right" or "jump_left" or "jump_right" or "idle":
		walkingSFX.stop()
	
	if animatedSprite.animation == "run_left":
		walkingSFX.play()
	if animatedSprite.animation == "run_right":
		walkingSFX.play()
