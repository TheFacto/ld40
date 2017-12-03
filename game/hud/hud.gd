extends CanvasLayer

var strandeesLabel

func _ready():
	set_process(true)
	strandeesLabel = get_node("strandees")
	
func _on_player_rescue_strandee(strandeesCount):
	strandeesLabel.set_text("strandees: " + str(strandeesCount))
	
	
    