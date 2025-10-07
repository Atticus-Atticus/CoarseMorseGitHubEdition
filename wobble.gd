extends Sprite2D
var rng = RandomNumberGenerator.new()
var startposx : int
var startposy : int
var halfstep = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startposx = position.x
	startposy = position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if halfstep:
		position.x = round(rng.randf_range(startposx - 5,startposx + 5))
		position.y = round(rng.randf_range(startposy - 5,startposy + 5))
	else :
		halfstep = not halfstep
	pass
