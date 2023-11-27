extends Control

@onready var timer = $Timer
@onready var game_over_label = $GameOverLabel
@onready var press_space_label = $PressSpaceLabel
var can_continue : bool = false


func _ready():
	GameManager.on_game_over.connect(on_game_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_continue:
		if Input.is_action_just_pressed("fly"):
			GameManager.load_main_scene()


func _on_timer_timeout():
	run_sequence()

func on_game_over() -> void:
	show()
	timer.start()

func run_sequence():
	game_over_label.hide()
	press_space_label.show()
	can_continue = true
