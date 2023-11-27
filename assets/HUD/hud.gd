extends Control

@onready var score_label = $MC/ScoreLabel

func _ready():
	GameManager.on_score_updated.connect(on_score_updated)

func update_label():
	score_label.text = str(GameManager.get_score())

func on_score_updated():
	update_label()  
