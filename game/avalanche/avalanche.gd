extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var speed = 0.75

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	connect("body_enter", self, "_on_collision")

func _process(delta):
	var scale = get_pos()
	set_pos(Vector2(scale.x, scale.y + speed))

func _on_collision(value):
	if(value.has_method("kill")):
		value.kill()
	

