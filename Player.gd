extends KinematicBody2D


export (float, 0, 1.0) var friction = 0.2
export (float, 0, 1.0) var acceleration = 0.5
var speed: int
var runSpeed: int = 600
var walkSpeed: int = 400
var toggleRun = true



var spawn: Vector2 = Vector2()
var jumpForce: int = 1000
var gravity : int = 2000
var vel: Vector2 = Vector2()
var jump_pressed #variable that check if the jump key is keep pressed
var jump  #variable that check if the jump key is just pressed

onready var doublejump = true

#onready var douJump : int =0

onready var sprite : Sprite = get_node("Sprite")
	
func isPlayer():
	return true

func _ready(): 

	spawn.x = -576
	spawn.y = 1344
	speed = walkSpeed


	


func get_input():
	#dash (?)
	if Input.is_action_just_pressed("right_mouse"):
		vel.x = vel.x * 20
	


	#sprint
	if Input.is_action_just_pressed("shift"):
		toggleRun = !toggleRun
		if toggleRun:
			speed = runSpeed
		if !toggleRun:
			speed = walkSpeed
			
	var dir = 0
	if Input.is_action_pressed("move_right"):
		dir += 1
	if Input.is_action_pressed("move_left"):
		dir -= 1
	if dir != 0:
		vel.x = lerp(vel.x, dir * speed, acceleration)
	else:
		vel.x = lerp(vel.x, 0, friction)
	
	jump_pressed = Input.is_action_pressed('move_jump') #jump button is keep pressed
	
	jump = Input.is_action_just_pressed('move_jump')   #jump button is just pressed
	if jump && (is_on_floor() || doublejump):  # check if the jump button is just pressed and if the player is on the floor
		if (!is_on_floor() && doublejump):
			doublejump = false
		jump() # call jump method

	if vel.y < 0 && !jump_pressed: # here is the deal: if the jump button is not keep pressed anymore, the y velocity is set to 0 and the player don't go up anymore
		vel.y = 0
	
func jump():
	vel.y = -jumpForce


func _physics_process(delta):
	if is_on_floor():
		doublejump = true

	get_input()
	
	# gravity
	vel.y += gravity * delta
	
	#applying velocity 
	vel = move_and_slide(vel, Vector2.UP)
	
	#sprite direction
	#if vel.x < 0:
	#	sprite.flip_h = true
	#elif vel.x > 0: 
	#	sprite.flip_h = false
		

