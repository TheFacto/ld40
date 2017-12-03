extends Area2D

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	
func _process(delta):
	if (Input.is_action_pressed("ui_accept")):
		get_tree().change_scene("res://stage.tscn")
