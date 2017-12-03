extends KinematicBody2D

func _ready():
	get_node("Area2D").connect("body_enter", self, "_on_collision")
	
func _on_collision(value):
	if(value.get_name() == "player"):
		get_node("SamplePlayer2D").play("player-land")
