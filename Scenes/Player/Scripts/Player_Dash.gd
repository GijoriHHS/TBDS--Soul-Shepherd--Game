extends PlayerState
class_name Player_Dash
@onready var timer: Timer = $Timer

func Enter():
	super()
	sprite.play("Jump")
	timer.start()
func Exit():
	player.velocity.x = 0

func Phys_Update(_delta:float):
	var direction = -1 if sprite.flip_h else 1
	player.velocity.y = 0
	player.velocity.x = direction * walk_speed
	
	player.move_and_slide()

func _on_timer_timeout() -> void:
	state_transition.emit(self, "Idling")
