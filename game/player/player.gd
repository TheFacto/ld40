extends KinematicBody2D


const GRAVITY_VEC = Vector2(0,100)
const FLOOR_NORMAL = Vector2(0,-1) # the direction of the ground
const FALLING_SPEED_DEATH_THRESHOLD = 2000 #pixels/sec 

const FLOAT_EPSILON = 0.0001

static func compare_floats(a, b, epsilon = FLOAT_EPSILON):
    return abs(a - b) <= epsilon

export var walk_speed = 100 # pixels/sec
export var maxJumpTime = 0.6
export var jumpSpeed = 1000
export var gravityFactor = 20

var linear_vel = Vector2()
var strandees = 0
var alive = true
var is_still = false
var jumpTime = 0

signal rescue_strandee

func get_strandees():
	return strandees

func _fixed_process(delta):
	#_gravity(delta)
	_move_sideways(delta)
	_jump(delta)
	_dead(delta)
	_detect_still()
	_gravity(delta)

	# Commits the velocity to the kinematic body
	linear_vel = move_and_slide(linear_vel, FLOOR_NORMAL)
	
func _gravity(delta):
	if(!is_move_and_slide_on_floor()):
		linear_vel.y = (linear_vel.y + gravityFactor)

# Calculates new speeds based on whether the user has pressed left or right
func _move_sideways(delta):
	var target_speed = 0
	
	if (Input.is_action_pressed("player_left")):
		target_speed = -1
		face_left()
		_walking_animation()
		
	if (Input.is_action_pressed("player_right")):
		target_speed = 1
		face_right()
		_walking_animation()
		
	target_speed *= walk_speed
	linear_vel.x = lerp( linear_vel.x, target_speed, 0.1 )
	
func _walking_animation():
	is_still = false
	var anim = get_node("animation")
	if (not anim.is_playing() or (anim.is_playing() and anim.get_current_animation() != "walk")):
		anim.play("walk")
	
func _detect_still():
	if (not is_still and is_move_and_slide_on_floor() and linear_vel.x == 0):
		is_still = true
		get_node("animation").play("still")

func _jump(delta):
	var pressedJump = Input.is_action_pressed("player_jump")
	var isOnFloor = is_move_and_slide_on_floor()
	var isZero = compare_floats(jumpTime, 0)
	
	if(pressedJump || ((jumpTime < 0) && !isZero && !isOnFloor)):
		if(isOnFloor):
			linear_vel.y = -jumpTime * -jumpSpeed
			jumpTime = maxJumpTime
		elif(jumpTime > 0 && !isZero):
			linear_vel.y = jumpTime * -jumpSpeed
			jumpTime -= delta
	else:
		jumpTime = 0

func _ready():
	set_fixed_process(true)

func capture_strandee():
	strandees += 1
	_update_backpack()
	emit_signal("rescue_strandee", strandees)
	

func _update_backpack():
	get_node("Backpack/Sprite").set_frame(strandees + 1)
		
func _dead(delta):
	if ((linear_vel.y > FALLING_SPEED_DEATH_THRESHOLD) or not alive):
		get_tree().reload_current_scene()
		
func kill():
	alive = false

func face_left():
	get_node("Sprite").set_flip_h(true)
	
func face_right():
	get_node("Sprite").set_flip_h(false)
	

