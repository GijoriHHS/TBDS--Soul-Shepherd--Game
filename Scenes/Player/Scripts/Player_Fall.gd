extends PlayerState
class_name Player_Fall

func Enter():
	super()
	sprite.play("Jump")

func Update(_delta:float):
	if player.is_on_floor():
		state_transition.emit(self, "Idling")
		
	if Input.is_action_just_pressed("LeftClick"):
		state_transition.emit(self, "AirAttack1")
	if Input.is_action_just_pressed("Shift"):
		state_transition.emit(self, "Dash")
	if Input.is_action_just_pressed("RightClick"):
		state_transition.emit(self, "Archery")

func Phys_Update(_delta:float):
	movement(_delta)
