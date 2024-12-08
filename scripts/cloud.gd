extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += 100 * delta


func _on_despawn_timer_timeout() -> void:
	self.queue_free()
