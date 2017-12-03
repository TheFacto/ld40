extends Node2D
signal rescue_completed

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_Area2D_body_enter( body ):
	if (not body.has_method("rescued")):
		return
	
	body.rescued()
	get_node("anim").play("flyAway")

func rescue_completed():
	emit_signal("rescue_completed")

func _on_CloseToGround_body_enter( body ):
	if (not body.has_method("on_close_to_ground")):
		return
	body.on_close_to_ground()
