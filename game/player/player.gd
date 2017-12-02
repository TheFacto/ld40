extends KinematicBody2D


const GRAVITY_VEC = Vector2(0,100)
const WALK_SPEED = 100 # pixels/sec
const FLOOR_NORMAL = Vector2(0,-1) # the direction of the ground
const JUMP_SPEED = 125

var linear_vel = Vector2()
var jumping = false
var strandees = 0

func _fixed_process(delta):
	_gravity(delta)
	_move_sideways(delta)
	_jump(delta)
	
	# Commits the velocity to the kinematic body
	linear_vel = move_and_slide(linear_vel, FLOOR_NORMAL)

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
	
func _jump(delta):
	if (jumping and linear_vel.y > 0):
		jumping = false
	
	if (Input.is_action_pressed("player_jump") and not jumping and is_move_and_slide_on_floor()):
		linear_vel.y = -JUMP_SPEED
		jumping = true	

func _ready():
	set_fixed_process(true)
	
func capture_strandee():
	print("captured!")
	strandees += 1
	_update_backpack()
	
func _update_backpack():
	get_node("Backpack/Sprite").set_frame(strandees)
