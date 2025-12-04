extends enemy

class_name boss_enemy_1

@export var jump_speed: int = -125.0
@onready var JumpTimer : Timer = $JumpTimer

func _ready() -> void:
	projectile = load("res://Scenes/Weapons/hat_projectile.tscn")
	super._ready()
	JumpTimer.start()

func _on_area_2d_body_shape_entered() -> void:
	super._on_area_2d_body_shape_entered()
	speed = 40

func _on_area_2d_body_shape_exited() -> void:
	super._on_area_2d_body_shape_exited()
	speed = 20

func _process(_delta: float) -> void:
	super._process(_delta)
	if is_on_floor() and !ground.enabled:
		ground.set_enabled(true)

func _on_jump_timer_timeout() -> void:
	if can_jump:
		jump()
	
func jump():
	velocity.y = jump_speed
	ground.set_enabled(false)

func shoot():
	super.shoot()
	$HatSplitTimer.start()

func _on_hat_split_timer_timeout() -> void:
	var duplicated_hat = main.find_child("Instances")
	pass
