extends Node2D
@onready var cloudScene = load("res://scenes/cloud.tscn")
@onready var selectScene = load("res://scenes/monster_select.tscn")
@onready var winScene = load("res://scenes/game_won_scene.tscn")
@onready var carSound = $carRev
@onready var progBar = $ProgressBar
@onready var cloudTimer = $CloudSpawnTimer
@onready var animPlayer = $AnimationPlayer
var rng = RandomNumberGenerator.new()

var cloudInstance
var cloudSpawnPos
var cloudSpawnTime

var selectInstance
var winInstance


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#set levelprog bar
	progBar.value=GameData.levelProgress
	
	#let player select monster if not done yet
	selectInstance = selectScene.instantiate()
	if GameData.getPlayerMonster() == null:
		
		selectInstance.position = Vector2(100,100)
		add_child(selectInstance)
		
	#check for complete, reset and send back to home
	if GameData.levelProgress == 5:
		GameData.reset()
		winInstance = winScene.instantiate()
		winInstance.position = Vector2(100,100)
		add_child(winInstance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass



func _on_cloud_spawn_timer_timeout() -> void:
	cloudSpawnPos = rng.randf_range(0, 170)
	
	cloudInstance = cloudScene.instantiate()
	cloudInstance.position = Vector2(-150,cloudSpawnPos)
	add_child(cloudInstance)
	cloudSpawnTime = rng.randf_range(.5, 7)
	cloudTimer.wait_time = cloudSpawnTime
	
	


func _on_next_button_pressed() -> void:
	
	animPlayer.play("drive")
	carSound.play()
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://scenes/battle_screen.tscn")
	
