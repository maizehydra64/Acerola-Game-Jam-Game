extends Node3D

signal paused
var is_paused = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	var just_paused:bool = false
	if event.is_action_released("ui_cancel")&& is_paused == false && just_paused == false:
		pause()
		just_paused = true
	if event.is_action_released("ui_cancel") && is_paused == true && just_paused==false:
		unpause()
		
func pause():
	paused.emit()
	is_paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$"Gui/Pause Menu".visible = true
	$"Gui/In-game Gui".visible = false
	
func unpause():
	paused.emit()
	is_paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$"Gui/In-game Gui".visible = true
	$"Gui/Pause Menu".visible = false
