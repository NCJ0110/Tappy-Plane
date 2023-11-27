extends Node2D

@onready var pipe_holder = $PipeHolder
@onready var marker_top = $MarkerTop
@onready var marker_bot = $MarkerBot
@onready var pipe_spawn_timer = $PipeSpawnTimer
@onready var engine_sound = $EngineSound
@onready var game_over_sound = $GameOverSound
@export var pipes_scene : PackedScene


func _ready():
	GameManager.set_score(0)
	GameManager.on_game_over.connect(on_game_over)
	pipe_spawn_timer.start()
	spawn_pipes() 

func spawn_pipes() -> void:
	var y_pos = randf_range(marker_bot.position.y, marker_top.position.y)
	var new_pipes = pipes_scene.instantiate()
	new_pipes.position = Vector2(marker_bot.position.x, y_pos)
	pipe_holder.add_child(new_pipes, true)
func _on_pipe_spawn_timer_timeout():
	spawn_pipes()
	
func stop_pipes():
	pipe_spawn_timer.stop()
	for pipe in pipe_holder.get_children():
		pipe.set_process(false)
	
func on_game_over():
	stop_pipes()
	engine_sound.stop()
	game_over_sound.play()
