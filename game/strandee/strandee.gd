extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _fixed_process(delta):
	move(Vector2(0, 0.5))

func _ready():
	pass
	# set_fixed_process(true)


func _on_Area2D_body_enter( body ):
	if (body.has_method("capture_strandee")):
		body.capture_strandee()
		queue_free()
