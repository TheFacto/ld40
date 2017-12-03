extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	
func _process(delta):
	if (Input.is_action_pressed("ui_accept")):
		get_tree().change_scene("res://stage.tscn")
