extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.get_vignette(self.material)
