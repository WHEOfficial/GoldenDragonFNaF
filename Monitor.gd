extends CSGBox3D

signal camera_event

@export var interactDistance = 3

@onready var player = $"../../Player"
@onready var hud = $"../../HUD"
@onready var cameraNotif = hud.get_node("CameraNotification")
@onready var cameraStatic: AnimatedSprite2D = hud.get_node("Static")
@onready var cameras = $"../../Cameras"
@onready var cameraNodes = cameras.get_children().filter(func(n): return !(n is Camera3D))

var playerNearMonitor = false
var inCamera = false
var distance
var currentCameraIndex = 0
var currentCamera: Node3D
var camera: Camera3D


func _ready():
	currentCamera = cameraNodes[currentCameraIndex]
	camera = currentCamera.get_node("SecurityCamera")


func update_camera(newIndex):
	currentCameraIndex = newIndex
	currentCamera.remove_child(camera)
	currentCamera = cameraNodes[currentCameraIndex]
	currentCamera.add_child(camera)


func _process(delta):
	distance = position.distance_to(player.position)
	playerNearMonitor = distance < interactDistance
	cameraNotif.visible = playerNearMonitor and not inCamera
	var cameraBool
	if Input.is_action_just_pressed("interact") and playerNearMonitor:
		cameraBool = Input.is_action_just_pressed("interact") and not inCamera
		inCamera = cameraBool
		player.get_node("Head/Camera3D").set_current(!cameraBool)
		camera.set_current(cameraBool)
		cameraStatic.visible = cameraBool
		camera_event.emit(cameraBool)
	
	if Input.is_action_just_pressed("right") and inCamera:
		update_camera((currentCameraIndex + 1) % cameraNodes.size())
		
	if Input.is_action_just_pressed("left") and inCamera:
		update_camera((currentCameraIndex - 1) % cameraNodes.size())
