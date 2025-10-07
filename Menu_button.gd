extends Node

@onready var notpressed = $Up
@onready var pressed = $Down
@onready var beep = $AudioStreamPlayer

var morse = false
var time: float = 0
var button_enabled = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass






func _on_button_button_down() -> void:
	pass # Replace with function body.


func _on_button_button_up() -> void:
	notpressed.show()
	pressed.hide()
	beep.stop()
	morse = false
	var release_time = Time.get_ticks_msec() / 1000.0
	var time_passed = release_time - time
	#if time_passed > 0 and time_passed < .2 :
		#outputmessage.text += " ●"
	#elif time_passed < 4 :
		#outputmessage.text += " ━"
	#else:
		#outputmessage.text            +=  " ?"


func _on_button_pressed() -> void:
	notpressed.hide()
	pressed.show()
	beep.play()
	if button_enabled:
		morse = true
		time = Time.get_ticks_msec() / 1000.0
