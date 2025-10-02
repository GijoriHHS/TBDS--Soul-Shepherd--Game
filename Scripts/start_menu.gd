extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	print("gedrukt op start")
	get_tree().change_scene_to_file("res://Scenes/Level/level_1.tscn")
	Engine.time_scale = 1

func _on_customized_pressed() -> void:
	print("This scene does not exist yet")


func _on_options_pressed() -> void:
	print("This scene does not exist yet")


func _on_exit_pressed() -> void:
	get_tree().quit()
