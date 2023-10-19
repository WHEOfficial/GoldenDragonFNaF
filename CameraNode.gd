extends Node3D

@export var timeToRotate = 3
@export var degreeOfRotation = 15

@onready var delayTimer = $DelayTime
@onready var initialAngle = rotation.y

var rotating = true
var rotatingDirection = false


func _ready():
	rotate_y(deg_to_rad(-degreeOfRotation))


func _process(delta):
	if rotating:
		var rotateSign = 1 if rotatingDirection else -1
		var destinationAngle = initialAngle + (deg_to_rad(degreeOfRotation) * rotateSign)
		rotate_y(deg_to_rad(rotateSign * degreeOfRotation * 2) / timeToRotate * delta)
		if (rotatingDirection and rotation.y > destinationAngle) or \
			(!rotatingDirection and rotation.y < destinationAngle):
			delayTimer.start()
			rotating = false
 

func _on_delay_time_timeout():
	rotatingDirection = !rotatingDirection
	rotating = true
