extends KinematicBody2D


const GRAVITY_VEC = Vector2(0,100)
const WALK_SPEED = 100 # pixels/sec
const FLOOR_NORMAL = Vector2(0,-1) # the direction of the ground

var linear_vel = Vector2()

func _fixed_process(delta):
	_gravity(delta)
	_move_sideways(delta)
	
	# Commits the velocity to the kinematic body
	move_and_slide(linear_vel, FLOOR_NORMAL)

func _gravity(delta):
	linear_vel += delta * GRAVITY_VEC

# Calculates new speeds based on whether the user has pressed left or right
func _move_sideways(delta):
	var target_speed = 0
	if (Input.is_action_pressed("player_left")):
		target_speed = -1
	if (Input.is_action_pressed("player_right")):
		target_speed = 1
	target_speed *= WALK_SPEED
	linear_vel.x = lerp( linear_vel.x, target_speed, 0.1 )

func _ready():
	set_fixed_process(true)
