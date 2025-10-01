extends CharacterBody2D

signal player_hit
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var finite_state_machine: FSM
@export var hp : HP

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@export var velocity2D : Vector2
@onready var game_manager: Node = %GameManager

func _process(_delta: float) -> void:
	velocity2D = velocity 
	game_manager.updateLabel(finite_state_machine.current_state.name)
	game_manager.updateHP(hp.hp)
	if Input.is_action_just_pressed("reset"):
		player_hit.emit(50)
	if hp.hp <= 0:
		collision_shape_2d.disabled = true
		game_manager.updateGameOver()
		
func SetShader_BlinkIntensity(newValue: float):
	sprite.material.set_shader_parameter("blink_intensity", newValue)


func _on_killzone_body_entered(body: Node2D) -> void:
	player_hit.emit(50)


func _on_health_hp_changed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity, 1.0, 0.0, 0.5)
	
	gpu_particles_2d.restart()
	gpu_particles_2d.emitting = true
