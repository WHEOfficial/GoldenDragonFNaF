extends Control

@onready var powerLeft: Label = $PowerLeft
@onready var hourDisplay: Label = $Hour

@onready var minuteTimer = $Hour/Timer

var power = 1000
var elapsedTime = 0

var elapsedMinute = 0
var elapsedHour: int = 12


func _on_timer_timeout():
	elapsedTime += 1
	
	elapsedMinute = elapsedTime % 60
	elapsedHour = (elapsedTime / 60 + 12) % 12
	if elapsedHour == 0:
		elapsedHour = 12
		
	elapsedMinute = "%02d" % elapsedMinute
	
	hourDisplay.text = str(elapsedHour) + ":" + elapsedMinute + " AM"
