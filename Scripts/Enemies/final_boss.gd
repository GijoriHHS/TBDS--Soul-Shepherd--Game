extends enemy

class_name final_boss

@export var jump_speed: int = -125.0
@onready var JumpTimer : Timer = $JumpTimer
@onready var WalkTimer: Timer = $WalkTimer
@onready var ShockwaveArea : CollisionShape2D = $Shockwave/CollisionShape2D
@onready var player_hp = load("res://Scripts/Player/General/health.gd")
var just_jumped: bool = false

func _ready() -> void:
	$in_range_shoot_timer.wait_time = 1
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
			sprite.play("Attack_Ground_Slam")
	if just_jumped and ground.is_colliding():
		just_jumped = false
		gravity = 300
		WalkTimer.start()
		shoot("ground_attack")
	if speed != 0 and ground.is_colliding():
		sprite.play("Walking")
	elif speed == 0 and ground.is_colliding() and !sprite.is_playing():
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
	if raycastcheckleft.is_colliding() and (raycastcheckleft.get_collision_point().x - global_position.x >= -20):
		shoot("punch")
	elif raycastcheckright.is_colliding() and (raycastcheckright.get_collision_point().x - global_position.x <= 20):
		shoot("punch")
	else:
		if randi_range(1,2) == 1:
			can_move = false
			jump(-200)
			just_jumped = true
		else:
			sprite.play("Clap")
			shoot("clap")

func shoot(attack: String):
	if attack == "clap":
		can_move = false
		ShockwaveArea.position.y = 1.97
		WalkTimer.start(1)
		if !ShockwaveArea.disabled:
			ShockwaveArea.set_disabled(true)
			await get_tree().process_frame
			ShockwaveArea.set_disabled(false)
		else:
			ShockwaveArea.set_disabled(false)
	elif attack == "ground_attack":
		ShockwaveArea.position.y = 8.64
		ShockwaveArea.set_disabled(false)
	elif attack == "punch":
		print("punch")
	
func _on_animated_sprite_2d_animation_finished(anim_name: String) -> void:
	sprite.play("Idle")

func _on_walk_timer_timeout() -> void:
	can_move = true
	ShockwaveArea.set_disabled(true)
	sprite.play("Idle")

func _on_shockwave_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player.hp.take_damage(10)
