extends PlayerState
class_name Player_Fall


@export var dash_cooldown : Timer
@export var landing_sfx : AudioStreamPlayer2D

@export var max_landing_shake : float = 3
@export var min_landing_shake : float = 0.15
@export var max_blur_strength : float =  0.008
@export var min_blur_strength : float =  0.001
@export var max_duration : float =  0.38
@export var min_duration : float =  0.03
@export var max_landing_volume : float = 25
@export var min_landing_volume : float = -10
@export var max_squash_str : float =  0.4
@export var min_squash_str : float =  0.1
@export var max_squash_duration : float =  0.35
@export var min_squash_duration : float =  0.15

var last_velocity_y : float = 0.0

var can_airglide: bool = false
var jump_hold_time : float = 0.0
var jump_hold_threshold : float = 0.2  # hoeveel seconden vastgehouden voor airglide
var jump_pressed : bool = false


@onready var can_airglide_label: Label = $"../../../CanvasLayer/can_airglide_label"

func Enter():
	super()
	#double_jumps_left = extra_jumps
	sprite.play("Panda_Jump")
	last_velocity_y = 0.0
	#print("Double jumps left: ", jumps_left)

func Update(_delta:float) -> void:
	if player.velocity.y > 0:
		last_velocity_y = player.velocity.y

	if player.is_on_floor():
		_play_landing_effects()
		state_transition.emit(self, "Idling")
		jumps_left = 1

	if Input.is_action_just_pressed("LeftClick") and get_item_by_name("Weapon", slots).visible:
		state_transition.emit(self, "Attack1")
	if Input.is_action_just_pressed("Shift") and dash_cooldown.is_stopped():
		state_transition.emit(self, "Dash")
	if Input.is_action_just_pressed("LeftClick") and get_item_by_name("Bow", slots).visible:
		state_transition.emit(self, "Archery")
		
	if Input.is_action_pressed("WallSlide") and player.is_on_wall_only():
		state_transition.emit(self, "Wallsliding")
	if Input.is_action_just_pressed("Jump") and player.is_on_wall_only() and (Input.is_action_pressed("Left") or Input.is_action_pressed("Right")):
		state_transition.emit(self, "WallJump")
		
	if Input.is_action_just_pressed("Jump") and not player.is_on_floor():
		jump_pressed = true
		jump_hold_time = 0.0  # reset timer bij elke nieuwe druk

	if jump_pressed:
		jump_hold_time += _delta
	
	# Double jump als knop snel wordt ingedrukt en losgelaten
	if Input.is_action_just_released("Jump") and not player.is_on_floor():
		if jump_hold_time < jump_hold_threshold and jumps_left > 0:
			jumps_left -= 1
			state_transition.emit(self, "Doublejump")
			jump_pressed = false
			can_airglide = false  # voorkom airglide na double jump
		elif jump_hold_time >= jump_hold_threshold and can_airglide:
			jump_pressed = false
	
	if Input.is_action_pressed("Jump") and not player.is_on_floor() and jump_hold_time >= jump_hold_threshold and can_airglide:
		can_airglide = false
		state_transition.emit(self, "Airgliding")
		jump_pressed = false
		

func Phys_Update(_delta:float) -> void:
	if Input.is_action_just_released("Jump") and !player.is_on_floor():
		can_airglide = true
	can_airglide_label.text = "can_airglide: " + str(can_airglide)
	movement(_delta)

func _play_landing_effects() -> void:
	var animated_sprite : AnimatedSprite2D = player.get_node("AnimatedSprite2D")
	
	var intensity : float = clamp(last_velocity_y / 800.0, 0.0, 1.0)
	
	var shake_amount : float = lerp(min_landing_shake, max_landing_shake, intensity)
	var blur_amount : float = lerp(min_blur_strength, max_blur_strength, intensity)
	var duration : float = lerp(min_duration, max_duration, intensity)
	var volume : float = lerp(min_landing_volume, max_landing_volume, intensity)
	var squash_duration : float = lerp(min_squash_duration, max_squash_duration, intensity)
	var squash_str : float = lerp(min_squash_str, max_squash_str, intensity)
	
	UtilsEffect.screenshake(level_camera, shake_amount, duration, 25.0)
	UtilsEffect.apply_directional_blur(animated_sprite, duration, blur_amount, 45)
	landing_sfx.volume_db = volume
	landing_sfx.play()
	UtilsEffect.squash(sprite, squash_duration, squash_str)
