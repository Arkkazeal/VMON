extends CharacterBody2D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const FALL_SPEED_OFFSET = 1.5

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var time: float = 0.0
var seconds = 0
var moving = true
var animation = true

@onready var _animated_sprite = $AnimatedSprite2D

func _ready():
	_animated_sprite.play("Idle")
	while animation == true:
		await change_action()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta + FALL_SPEED_OFFSET
		
	time += delta
	seconds = fmod(time, 60)
	
	move_and_slide()

func change_action():
	#get random action and change current action
	var current_action = get_random_number(1, 5)
	print (current_action)
	if current_action == 1:
		await move_left(get_random_number(2, 10))
	elif current_action == 2:
		await move_right(get_random_number(2, 10))
	elif current_action == 3:
		await hop_character()
	else:
		await get_tree().create_timer(1.0).timeout
		_animated_sprite.play("Idle")
		await wait_character(get_random_number(0, 4))
	

func move_right(steps):
	scale.x = 10
	for i in range(steps):
		await get_tree().create_timer(1.0).timeout
		move_and_collide(Vector2(10,0))
	
func move_left(steps):
	scale.x = -10
	for i in range(steps):
		await get_tree().create_timer(1.0).timeout
		move_and_collide(Vector2(-10,0))
		
func wait_character(steps):
	for i in range(steps):
		await get_tree().create_timer(1.0).timeout
		
func hop_character():
	_animated_sprite.play("Happy")
	move_and_collide(Vector2(0,-20))

func get_random_number(low, high):
	randomize()
	return randi_range(low, high)
