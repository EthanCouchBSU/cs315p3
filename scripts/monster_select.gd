extends Node2D
@onready var animPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_button_pressed() -> void:
	if(GameData.getPlayerMonster() != null):
		self.queue_free()


func _on_rc_button_pressed() -> void:
	GameData.setPlayerMonster("Racoon")


func _on_dg_button_pressed() -> void:
	GameData.setPlayerMonster("Dog")


func _on_sq_button_pressed() -> void:
	GameData.setPlayerMonster("Squirrel")
	
	
#mouse over anims----------------


func _on_rc_button_mouse_entered() -> void:
	animPlayer.play("racoonSelect")


func _on_rc_button_mouse_exited() -> void:
	animPlayer.stop()


func _on_dg_button_mouse_entered() -> void:
	animPlayer.play("dogSelect")


func _on_dg_button_mouse_exited() -> void:
	animPlayer.stop()


func _on_sq_button_mouse_entered() -> void:
	animPlayer.play("squirrelSelect")


func _on_sq_button_mouse_exited() -> void:
	animPlayer.stop()
