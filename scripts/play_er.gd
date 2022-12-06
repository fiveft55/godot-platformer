extends KinematicBody2D

# Constants
const TYPE = "play_er"

# variables
export (int) var speed = 200
export (int) var jmp_speed = -230
export (int) var gravity = 500
export (int) var slide = 500 #not used

var velocity = Vector2.ZERO

export (float) var friction = 10
export (float) var accel = 25

# _Input_ctrl
func get_input():
	var dir = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if dir != 0:
		velocity.x = move_toward(velocity.x, dir*speed, accel)
		#print("working")
	else:
		velocity.x = move_toward(velocity.x, 0, friction)
		#print("yep")
	pass

# _Main_process_ctrl
func _physics_process(delta):
	# call_input_ctrl
	get_input()
	
	#Prototype... basic_jump
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = jmp_speed
	
	
	# Set_gravity and aplly physics_in_game
	velocity.y += gravity*delta
	velocity = move_and_slide(velocity, Vector2.UP)




func _on_map_out_body_entered(body):
	if body.get("TYPE") == "play_er":
		get_tree().reload_current_scene()

func _on_spike_out_body_entered(body):
	if body.get("TYPE") == "play_er":
		get_tree().reload_current_scene()


func _on_gate_body_entered(body):
	if body.get("TYPE") == "play_er":
		get_tree().change_scene("res://scenes/end_game.tscn")
