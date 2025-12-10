extends enemy

class_name boss_enemy_1

@export var jump_speed: int = -125.0
@onready var JumpTimer : Timer = $JumpTimer
var just_jumped: bool = false

func _ready() -> void:
	projectile = load("res://Scenes/Weapons/enemy_hat_projectile.tscn")
	super._ready()
	JumpTimer.start()
	speed = 0

func _process(_delta: float) -> void:
	super._process(_delta)
	if is_on_floor() and !ground.enabled:
		ground.set_enabled(true)
	if just_jumped and velocity.y == 0:
		shoot()
		just_jumped = false

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
	jump(-75)
	just_jumped = true

func shoot():
	super.shoot()
	$HatSplitTimer.start()

func _on_hat_split_timer_timeout() -> void:
	if is_instance_valid(latest_hat):
		var instance = projectile.instantiate()
		instance.sprite = sprite
		instance.spawnpos = latest_hat.global_position
		instance.spawnpos.y = instance.spawnpos.y - 10
		instance.velocity = latest_hat.velocity
		instance.direction = latest_hat.direction
		main.add_child.call_deferred(instance)
		await get_tree().process_frame
	$HatSplitTimer.stop()
