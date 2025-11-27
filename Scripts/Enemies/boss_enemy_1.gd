extends enemy

class_name boss_enemy_1

@export var jump_speed = -125.0
@onready var JumpTimer : Timer = $JumpTimer

func _ready() -> void:
	super._ready()
	JumpTimer.start()

func _on_area_2d_body_shape_entered() -> void:
	_correct_sprite()
	playerInRange = true
	speed = 40
	$in_range_shoot_timer.start()

func _on_area_2d_body_shape_exited() -> void:
	playerInRange = false
	speed = 20
	$in_range_shoot_timer.stop()


func _on_jump_timer_timeout() -> void:
	jump()
	print("Timeout")
	
func jump():
	velocity.y = jump_speed
