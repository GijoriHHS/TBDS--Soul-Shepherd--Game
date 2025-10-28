extends Node

@onready var unlocked_abilities: Array = []

signal update_debug_ability_label

enum ability_list {
	Dash,
	DoubleJump,
	WallJump,
	Wallsliding,
}

const INFO: Dictionary = {
	ability_list.Dash: {
		"name": "Dash",
		"description": "Press 'Shift' to Dash!"
	},
	ability_list.DoubleJump:{
		"name": "Double Jump",
		"description": "Press 'Jump' again in the air to Double Jump! \n \
						Land on the ground to refresh the Double Jump"
	},
	ability_list.WallJump: {
		"name": "Wall Jump",
		"description": "Press 'Jump' while going into a wall to Wall Jump!"
	},
	ability_list.Wallsliding: {
		"name": "Wall Slide",
		"description": "Move into a wall while falling to slow down and Wall Slide!"
	},
}
# Called when the node enters the scene tree for the first time.



func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
