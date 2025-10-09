extends Node

@onready var tweening = $AnimationPlayer
@onready var fadeout = $"../AnimationPlayer"
@onready var text = $Label
@onready var money = $Money
@onready var rent = $Rent

@onready var pressed = $"../Down"
@onready var not_pressed = $"../Up"

@onready var sfx = $"../Typewriter"

var textline = 0

func _ready() -> void:
	if Globals.day == 3:
		$"Resist Msg".show()
	else:
		$"Resist Msg".hide()
	
	pressed.hide()
	await get_tree().create_timer(3.5).timeout
	$"../CanvasLayer".queue_free()
	tweening.play("TweenText")
	sfx.play()
	Globals.day += 1

func _on_animation_finished(anim_name: StringName) -> void:
	textline += 1
	sfx.stop()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Dialogue") and textline == 1:
		get_tree().change_scene_to_file("res://node_2d.tscn")

	money.text = str(Globals.money)
	rent.text = str(Globals.rent)

func _on_button_button_down() -> void:
	pressed.show()
	not_pressed.hide()
	Input.action_press("Dialogue")


func _on_button_button_up() -> void:
	pressed.hide()
	not_pressed.show()
	Input.action_release("Dialogue")


func _on_button_pressed() -> void:
	pass # Replace with function body.
