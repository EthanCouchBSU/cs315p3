extends Node2D
@onready var playColor = $MarginContainer/VBoxContainer/PlayButton/PlayButtonColor
@onready var creditColor = $MarginContainer/VBoxContainer/CreditButton/CreditButtonColor
@onready var quitColor = $MarginContainer/VBoxContainer/QuitButton/QuitButtonColor
@onready var  creditScene = load("res://scenes/credits.tscn")
var creditInstance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#button press funcs------------------
func _on_quit_button_pressed() -> void:
	get_tree().quit()
func _on_credit_button_pressed() -> void:
	var creditInstance = creditScene.instantiate()
	creditInstance.position = Vector2(-200,-300)
	add_child(creditInstance)
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/home_screen.tscn")

#button hover funcs (should really turn into a scene but not going to rn this works fine)
func _on_play_button_mouse_entered() -> void:
	playColor.color =  Color(0.2,0.2,0.2)
func _on_play_button_mouse_exited() -> void:
	playColor.color = Color(.5,.5,.5)
func _on_credit_button_mouse_entered() -> void:
	creditColor.color =  Color(0.2,0.2,0.2)
func _on_credit_button_mouse_exited() -> void:
	creditColor.color = Color(0.5,0.5,0.5)
func _on_quit_button_mouse_entered() -> void:
	quitColor.color =  Color(0.2,0.2,0.2)
func _on_quit_button_mouse_exited() -> void:
	quitColor.color = Color(0.5,0.5,0.5)
