extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.set_meta("Inview",false)
	print(get_meta("Inview",true))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	if get_meta("Inview",true) : 
		position.x +=  (354 - position.x) * delta
	else :
		position.x +=  (-354 - position.x) * delta
