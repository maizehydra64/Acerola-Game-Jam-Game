extends CharacterBody3D
# Constants
const JUMP_VELOCITY = 4.5
# Exported Variables
@export var SPEED = 5.0
@export var rot_speed = 1.0
# Non-exported Variables
var is_paused:bool = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	if(is_paused==false):
		# Add the gravity.
		if not is_on_floor():
			velocity.y -= gravity * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("left", "right", "forward", "back")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()
	else:
		pass
		
func _input(event):
	if(is_paused==false):
		var delta = get_process_delta_time()
		if event.is_action("look_down") or event.is_action("look_left") or event.is_action("look_right") or event.is_action("look_up"):
			var look_dir = Input.get_vector("look_left","look_right","look_down","look_up")
			rotate_y(-look_dir.x*rot_speed*delta)
			$Camera3D.rotate_x(look_dir.y*rot_speed*delta)
			$Camera3D.rotation_degrees.x = clamp($Camera3D.rotation_degrees.x,-89.9,89.9)
		if Input.get_mouse_mode()==Input.MOUSE_MODE_CAPTURED:
			if event is InputEventMouseMotion:
				rotate_y(-event.relative.x*rot_speed*delta)
				$Camera3D.rotate_x(-event.relative.y*rot_speed*delta)
				$Camera3D.rotation_degrees.x = clamp($Camera3D.rotation_degrees.x,-89.9,89.9)

# pauses the player
func _on_node_3d_paused():
	print("test")
	if is_paused == false:
		is_paused = true
		print("now paused")
	elif is_paused == true:
		is_paused = false
		print("now unpaused")
