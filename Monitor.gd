extends CSGBox3D

@export var interactDistance = 3

@onready var player = $"../../Player"
@onready var cameraNotif = $"../../CanvasLayer/CameraNotification"
@onready var cameras = $"../Cameras"

var playerNearMonitor = false
var distance


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	distance = position.distance_to(player.position)
	playerNearMonitor = distance < interactDistance
	cameraNotif.visible = playerNearMonitor
	
	if Input.is_action_pressed("interact") and playerNearMonitor:
		player.get_node("Head/Camera3D").set_current(false)
		cameras.get_node("Camera1").set_current(true)
