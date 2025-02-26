extends Node2D

@onready var collider = $RigidBody2D/CollisionShape2D
@onready var disable_collision_timer = $Disable_Collision_Timer
@onready var enable_collision_timer = $Enable_Collision_Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		disable_collision_timer.start()

func _on_enable_collision_timer_timeout():
	collider.disabled = false

func _on_disable_collision_timer_timeout():
	collider.disabled = true
	enable_collision_timer.start()
