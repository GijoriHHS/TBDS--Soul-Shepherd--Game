extends PlayerState
class_name Player_Airgliding

@export var airglide_gravity: Vector2 = Vector2(0,200)
@export var default_gravity: Vector2 = Vector2(0,980)

@onready var airglide_active: Label = $"../../../CanvasLayer/Airglide_active"

func Enter():
	super()
	sprite.play("Panda_Jump")
	


func Phys_Update(_delta:float) -> void:
	if player.is_on_floor():
		state_transition.emit(self, "Idling")
	if player.velocity.y <= 0:
		airglide_active.text = "gliding down"
		custom_gravity = airglide_gravity
	#airglide_active.text = "In airglide"
	
	if Input.is_action_just_released("Jump"):
		airglide_active.text = ""
		state_transition.emit(self, "Falling")
		custom_gravity = default_gravity
		
	movement(_delta)
