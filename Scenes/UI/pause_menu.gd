extends Control
@onready var player: CharacterBody2D = $"../../Player"

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_continue_pressed() -> void:
	player.pauseMenu()

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/Start_Menu.tscn")
