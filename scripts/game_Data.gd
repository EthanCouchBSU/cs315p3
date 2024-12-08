extends Node

var monsterData= {}
var monsterFilePath = "res://other/monsters.json"

var levelProgress : int = 0
var playerMonster
var enemyMonster

var rng = RandomNumberGenerator.new()

func reset():
	levelProgress = 0
	playerMonster = null
func increaseLevel():
	levelProgress +=1
#player monster funcs
func setPlayerMonster(monsterIn):
	playerMonster = monsterData["Monster"][monsterIn]

func getPlayerMonster():
	return playerMonster
	
#enemy monster functions
func getEnemyMonster():
	return enemyMonster
func setEnemyMonster(monsterIn):
	enemyMonster = monsterData["Monster"][monsterIn]
func setEnemyMonsterToRand(roll):
	
	match roll:
		0:
			enemyMonster = monsterData["Monster"]["Racoon"]
		1:
			enemyMonster = monsterData["Monster"]["Dog"]
		2:
			enemyMonster = monsterData["Monster"]["Squirrel"]
func chooseRandomMonster():
	pass
#loading json file in gdscript, from godot documentation
func loadJsonFile(file):
	if FileAccess.file_exists(file):
		var fileData = FileAccess.open(file, FileAccess.READ)
		var result = JSON.parse_string(fileData.get_as_text())
		
		return result




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	monsterData = loadJsonFile(monsterFilePath)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
