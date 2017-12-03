extends RigidBody2D

export var max_strandees = 2

func _ready():
	get_node("Node2D/Label").set_text(String(max_strandees))


func _on_Area2D_body_enter( body ):
	print("weighted platform body enter")
	if (body.has_method("get_strandees") and body.get_strandees() >= max_strandees):
		get_node("Sprite/animation").play("dissapear")
	


func _on_animation_finished():
	queue_free()
