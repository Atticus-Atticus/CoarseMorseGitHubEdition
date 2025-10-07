extends Node

@onready var tweening = $AnimationPlayer
@onready var text = $Label

@onready var pressed = $"../Down"
@onready var not_pressed = $"../Up"

@onready var sfx = $"../Typewriter"

var textline = 0

func _ready() -> void:
	pressed.hide()
	await get_tree().create_timer(3.5).timeout
	$"../CanvasLayer".queue_free()
	tweening.play("TweenText")
	sfx.play()

func _on_animation_finished(anim_name: StringName) -> void:
	textline += 1
	sfx.stop()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Dialogue") and textline == 1:
		text.set_text("Ah, there you are, Echo Station! About damn time. You must be the new Operator. Welcome to the front. Or near enough to smell it.")
		tweening.play("TweenText")
		sfx.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 2:
		text.set_text("Your orders are simple, but vital: Command writes the code words, and you make sure our boys hear them. Every dash and every dot could be the difference between victory and defeat.")
		tweening.play("TweenText")
		sfx.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 3:
		text.set_text("You'll be working that Morse Code machine like your life depends on it. You've got limited time to transmit the code words, so keep sharp, keep steady, and don't freeze under pressure. Translate the messages as you see them.")
		tweening.play("TweenText")
		sfx.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 4:
		text.set_text("If you don't know Morse Code, we've issued you a standard field translator board. Use it. No shame in that.")
		tweening.play("TweenText")
		sfx.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 5:
		text.set_text("God speed, Operator. The war depends on you. Command out.")
		tweening.play("TweenText")
		sfx.play()
		
		#MEEEEEP

	if Input.is_action_just_pressed("Dialogue") and textline == 6:
		get_tree().change_scene_to_file("res://node_2d.tscn")


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
