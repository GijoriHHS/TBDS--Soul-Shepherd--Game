extends enemy

class_name final_boss

@export var jump_speed: int = -125.0
@onready var JumpTimer : Timer = $JumpTimer
@onready var WalkTimer: Timer = $WalkTimer
@onready var ShockwaveArea : CollisionShape2D = $Shockwave/CollisionShape2D
var just_jumped: bool = false
var latest_dir : int

func _ready() -> void:
	projectile = load("res://Scenes/Weapons/enemy_hat_projectile.tscn")
	super._ready()
	JumpTimer.start()
	speed = 0
	stage = 1
	if stage > 1:
		health.hp = 200


func _process(_delta: float) -> void:
	super._process(_delta)
	if is_on_floor() and !ground.enabled:
		ground.set_enabled(true)
	if just_jumped and velocity.y > 0 and !ground.is_colliding():
		if gravity != 2000:
			gravity = 2000
	if just_jumped and ground.is_colliding():
		just_jumped = false
		gravity = 300
		WalkTimer.start()
		shoot()
	if speed != 0:
		sprite.play("Walking")
	else:
		sprite.play("Idle")

func _on_jump_timer_timeout() -> void:
	$JumpChecker.position.x = dir*speed
	if can_jump and $JumpChecker.is_colliding():
		jump()
	
func jump(small_jump_speed = null):
	if small_jump_speed == null:
		velocity.y = jump_speed
	else:
		velocity.y = small_jump_speed
	ground.set_enabled(false)

func pre_shoot():
	can_move = false
	jump(-200)
	just_jumped = true

func shoot():
	ShockwaveArea.set_disabled(false)

func _on_stage_3_timer_timeout() -> void:
	shoot()
	$stage_3_timer.stop()
	
func _on_animated_sprite_2d_animation_finished() -> void:
	sprite.play("Idle")

func _on_walk_timer_timeout() -> void:
	can_move = true
	ShockwaveArea.set_disabled(true)


func _on_shockwave_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Player.damage()
