@tool
extends Node2D

@export var ability_name: AbilityData.ability_list = AbilityData.ability_list.Dash

#const ability_names = [
	#"Dash",
	#"Archery",
	#"Wallsliding",
	#"DoubleJump",
	#"WallJump"
#]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body is Player:
		AbilityData.add_collected_ability_add_to_list(ability_name)
		AbilityData.update_debug_ability_label.emit()
		AbilityData.update_delete_ability_buttons.emit()
		AbilityData.update_unlock_ability_buttons.emit()
		self.queue_free()
