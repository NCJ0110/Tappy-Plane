extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var cooldown_timer = $Cooldown

const GRAVITY : float = 600.0
const POWER : float = -400.0

var _cooldown = false
var _dead = false

func _physics_process(delta):
	apply_gravity(delta)
	apply_rotation()
	fly()
	move_and_slide()
	
	if is_on_floor():
		die()

func _on_cooldown_timeout():
	_cooldown = false

func apply_gravity(delta) -> void:
	velocity.y += GRAVITY * delta

func apply_rotation() -> void:
	if not _cooldown:
		if rotation_degrees <= 60:
			rotation_degrees += 1
	else:
		rotation_degrees = lerp(rotation_degrees, -45.0, 0.2)

func fly() -> void:
	if Input.is_action_just_pressed("fly") and not _cooldown:
		velocity.y = POWER 
		cooldown_timer.start()
		_cooldown = true

func die() -> void:
	if _dead == true:
		return
	_dead = true
	animated_sprite.stop()
	set_physics_process(false)
	GameManager.on_game_over.emit()
