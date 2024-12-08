extends Node2D

@onready var winScene = load("res://win_scene.tscn")
@onready var looseScene = load("res://lose_screen.tscn")
@onready var playerSprite = $playerSprite
@onready var enemySprite = $enemySprite
@onready var phealthbar = $PlayerHealthBar
@onready var ehealthbar = $EnemyHealthBar
@onready var debugLabel = $pDebug
@onready var eDebugLabel = $eDebug

var winInstance
var loseInstance
var playerMonster
var enemyMonster 
var rng = RandomNumberGenerator.new()
var roll =0

var pCommands = []
var eCommands = []

var pHasCharge:int =1
var eHasCharge:int =1

var pHasBlock:int =1
var eHasBlock:int =1

var pAtkVal:int 
var eAtkVal:int

var pDefVal:int 
var eDefVal:int

var pSpcVal:int
var eSpcVal:int
	
var pSpeedVal:int
var eSpeedVal:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#variables
	roll = rng.randi_range(0,2)
	GameData.setEnemyMonsterToRand(roll)
	enemyMonster = GameData.getEnemyMonster()
	playerMonster = GameData.getPlayerMonster()
	

	pAtkVal = playerMonster.get("atk")
	eAtkVal = enemyMonster.get("atk")

	pDefVal = playerMonster.get("def")
	eDefVal = enemyMonster.get("def")

	pSpcVal = playerMonster.get("spc")
	eSpcVal = enemyMonster.get("spc")
	
	pSpeedVal = playerMonster.get("spd")
	eSpeedVal =enemyMonster.get("spd")
	
	
	
	#ghetto load sprite functions
	playerSprite.texture = load(playerMonster.get("sprite"))
	enemySprite.texture = load(enemyMonster.get("sprite"))
#attacking script
func commandAttack(targetBar,targetAtk,atkCharge,enemyDef,enemyBlock):
	targetBar.value -= (targetAtk *atkCharge) - (enemyDef*enemyBlock)
	
	
#reset charge and block vals
func resetBlock(target):
	if target == "p":
		pHasBlock	 = 1
	elif target == "e":
		eHasBlock = 1
func commandBlock(target):
	if target == "p":
		pHasBlock	 = 2
	elif target == "e":
		eHasBlock = 2
func resetCharge(target):
	if target == "p":
		pHasCharge	 = 1
	elif target == "e":
		eHasCharge = 1
func commandCharge(target):
	if target == "p":
		pHasCharge = 2
	elif target == "e":
		eHasCharge = 2
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#add to arrary, if greater reset and add to begining
func addToCommand(command):
	if pCommands.size() < 3:
		pCommands.append(command)
	elif pCommands.size() >= 3:
		pCommands.clear()
		pCommands.append(command)
	
	debugLabel.text = str(pCommands)
func _on_atk_button_pressed() -> void:
	addToCommand("atk")


func _on_def_button_pressed() -> void:
	addToCommand("def")


func _on_spc_button_pressed() -> void:
	addToCommand("spc")


func _on_chg_button_pressed() -> void:
	addToCommand("chg")
#proccess commands
func procCommand(commandList,target,i):
	
		match commandList[i]:
			"atk":
				if target == "p":
					commandAttack(ehealthbar,pAtkVal,pHasCharge,eDefVal,eHasBlock)
				elif target == "e":
					commandAttack(phealthbar,eAtkVal,eHasCharge,pDefVal,pHasBlock)
				resetCharge(target)
			"spc":
				if target == "p":
					commandAttack(ehealthbar,pSpcVal,1,eDefVal,eHasBlock)
				elif target == "e":
					commandAttack(phealthbar,eSpcVal,1,pDefVal,pHasBlock)
				resetCharge(target)
			"def":
				commandBlock(target)
			"chg":
				commandCharge(target)
				
					
					
					
#choose random command for enemy
func pickEnemyCommand():
	var roll = rng.randi_range(0,3)
	match roll:
		0:
			eCommands.append("atk")
		1:
			eCommands.append("def")
		2:
			eCommands.append("chg")
		3:
			eCommands.append("spc")
			
			
			
#execute commands
func _on_go_button_pressed() -> void:
	if ( pCommands.size() < 3):
		debugLabel.text = "You need 3 inputs"
	else:
		for i in range(3):
			if eCommands.size() < 3:
				pickEnemyCommand()
			elif eCommands.size() >= 3:
				eCommands.clear()
				pickEnemyCommand()
		eDebugLabel.text = str(eCommands)
		for i in range(3):
			procCommand(pCommands,"p",i)
			procCommand(eCommands,"e",i)
	#check for victory, show appr. screen
	
	#lose
	if phealthbar.value <= 0:
		loseInstance = looseScene.instantiate()
		loseInstance.position = Vector2(100,100)
		add_child(loseInstance)
	#win
	if ehealthbar.value <=0:
		GameData.increaseLevel()
		winInstance = winScene.instantiate()
		winInstance.position = Vector2(100,100)
		add_child(winInstance)
			
