extends RigidBody3D

@export var speed = 5.0
@export var rot_speed = 1.0
@onready var camera := $Camera3D

var is_paused = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2(camera.rotation.x,rotation.y)
	var input_vector = Input.get_vector("left","right","forward","back")
	if(input_vector!=Vector2(0,0)):
		linear_velocity.z=(speed*input_vector.y*cos(direction.y)
		+speed*input_vector.x*sin(-direction.y))
		linear_velocity.x=(speed*input_vector.y*sin(direction.y)
		+speed*input_vector.x*cos(direction.y))
		linear_velocity.y=(speed*input_vector.y*sin(-direction.x))
		linear_velocity = linear_velocity.clamp(Vector3(-speed,-speed,-speed)
		,Vector3(speed,speed,speed))
	else:
		linear_velocity=Vector3(0*delta,0,0)
	
func _input(event):
	if is_paused == false:
		var delta1 = get_process_delta_time()
		if(Input.get_mouse_mode()==Input.MOUSE_MODE_CAPTURED):
			if event is InputEventMouseMotion:
				camera.rotate_x(-event.relative.y*rot_speed*delta1)
				angular_velocity.y = -event.relative.x*rot_speed
				camera.rotation_degrees.x = clamp(camera.rotation_degrees.x,-90,90)
			else:
				angular_velocity.y=0
					
		else:
			angular_velocity.y=0

func _on_node_3d_paused():
	if is_paused == false:
		is_paused = true
		print("now paused")
	elif is_paused == true:
		is_paused = false
		print("now unpaused")
