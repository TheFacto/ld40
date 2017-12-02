extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var isPlayerTouching = false
var currentTime = 0
var spriteFrames = 1
var interval = 0
export var time = 5.0

func _ready():
	currentTime = 0
	spriteFrames = get_node("Sprite").get_hframes()
	interval = (time/spriteFrames)
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
		currentTime += delta
	var currentFrame = int((currentTime / interval))
	get_node("Node2D/Label").set_text("%0.2f" % (time - currentTime))
	if(currentFrame < spriteFrames):
		get_node("Sprite").set_frame(currentFrame)
	if(currentTime >= time):
		print("TimedPlatform::destroy")
		queue_free()
