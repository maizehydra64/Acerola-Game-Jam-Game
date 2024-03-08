extends CharacterBody3D
# Constants
const JUMP_VELOCITY = 4.5
# Exported Variables
@export var base_speed = 5.0
@export var rot_speed = 1.0
@export_category("Sprint")
@export var stamina:float = 100.0
@export var sprint_mult = 1.5
@export var sprint_pen = 0.5
@export var stam_gain = 8.0
@export var stam_loss = 10.0
@export var penal_len = 50.0
# Non-exported Variables
var is_paused:bool = false
var out_of_breath:bool = false
var speed = 5.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	pass

func _physics_process(delta):
	if(is_paused==false):
		# Add the gravity.
		if not is_on_floor():
			velocity.y -= gravity * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var look_dir = Input.get_vector("look_left","look_right","look_down","look_up")
		rotate_y(-look_dir.x*rot_speed*delta)
		$Camera3D.rotate_x(look_dir.y*rot_speed*delta)
		$Camera3D.rotation_degrees.x = clamp($Camera3D.rotation_degrees.x,-89.9,89.9)
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("left", "right", "forward", "back")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
		if(Input.is_action_just_pressed("Flashlight")):
			if($Camera3D/SpotLight3D.visible):
				$Camera3D/SpotLight3D.visible=false
			else:
				$Camera3D/SpotLight3D.visible=true
		
		if stamina >= penal_len:
			out_of_breath = false
		if Input.is_action_pressed("Sprint")&&!out_of_breath:
			speed = base_speed * sprint_mult
			stamina -= stam_loss*delta
		else:
			speed = base_speed
			stamina += stam_gain*delta
			
		if stamina <=0.0:
			out_of_breath = true	
		if out_of_breath:
			speed = base_speed * sprint_pen
			
			
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)

		move_and_slide()
	else:
		pass
		
func _input(event):
	if(is_paused==false):
		var delta = get_process_delta_time()
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
