extends AnimatedSprite2D

@onready var _animated_sprite = $"."
var time: float = 0.0
var minutes: int = 0
var seconds: int = 0
var msec: int = 0
var hatch_time = 5
var egg_ready = false
var egg_hatching = false
var screen_clicked = false

func _ready():
	_animated_sprite.play("Idle")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		screen_clicked = true
	if screen_clicked:
		if egg_ready == false:
			time += delta
			msec = fmod(time, 1) * 100
			seconds = fmod(time, 60)
			minutes = fmod(time,3600) / 60
			
		if seconds >= hatch_time:
			egg_ready = true
			if egg_hatching == false:
				hatching()
		
func hatching():
	egg_hatching = true
	_animated_sprite.play("Hatching")
	await(_animated_sprite.animation_finished)
	get_tree().change_scene_to_file("res://scenes/room.tscn")

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			Input.action_press("ui_accept")
			print("something")
