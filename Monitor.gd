extends CSGBox3D

signal camera_event

@export var interactDistance = 3

@onready var player = $"../../Player"
@onready var cameraNotif = $"../../CanvasLayer/CameraNotification"
@onready var cameras = $"../Cameras"

var playerNearMonitor = false
var inCamera = false
var distance


func _ready():
	$AnimatedSprite3D.play()


func _process(delta):
	distance = position.distance_to(player.position)
	playerNearMonitor = distance < interactDistance
	cameraNotif.visible = playerNearMonitor and not inCamera
	var cameraBool
	if Input.is_action_just_pressed("interact"):
		cameraBool = Input.is_action_just_pressed("interact") and playerNearMonitor and not inCamera
		inCamera = cameraBool
		player.get_node("Head/Camera3D").set_current(!cameraBool)
		cameras.get_node("Camera1").set_current(cameraBool)
		camera_event.emit(cameraBool)
