extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.set_meta("Inview",true)
	print(get_meta("Inview",true))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	if get_meta("Inview",true) : 
		position.y +=  (-130 - position.y ) * delta
	else :
		position.y +=  (772 - position.y) * delta
