extends Button

var button_text: String = "Open Ability Menu"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	text = button_text

func _on_mouse_exited() -> void:
	text = ""


func _on_pressed() -> void:
	get_parent().AbilityInfoMenu()
