extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _fixed_process(delta):
	move(Vector2(0, 1))

func _ready():
	set_fixed_process(true)
