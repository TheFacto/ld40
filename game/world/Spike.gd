extends Area2D

func _ready():
	connect("body_enter", self, "_on_collision")

func _on_collision(value):
	if(value.get_name() == "player"):
		value.kill()
