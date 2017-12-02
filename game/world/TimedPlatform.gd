extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var isPlayerTouching = false
var currentTime = 0
export var time = 5

func _ready():
	currentTime = time
	set_fixed_process(true)
	get_node("Area2D").connect("body_enter", self, "_on_collision")
	get_node("Area2D").connect("body_exit", self, "_on_collision_exit")
	
func _on_collision(value):
	if(value.get_name() == "player"):
		isPlayerTouching = true
	
func _on_collision_exit(value):
	if(value.get_name() == "player"):
		isPlayerTouching = false
	
func _fixed_process(delta):
	if(isPlayerTouching):
		currentTime -= delta
	if(currentTime <= 0):
		print("DEATH")
		queue_free()
