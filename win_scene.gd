extends Node2D

@onready var exitColor = $ExitButton/ColorRect
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_button_pressed() -> void:
	
	get_tree().change_scene_to_file("res://scenes/home_screen.tscn")


func _on_exit_button_mouse_entered() -> void:
	exitColor.color =  Color(0.2,0.2,0.2)


func _on_exit_button_mouse_exited() -> void:
	exitColor.color =  Color(0.5,0.5,0.5)
