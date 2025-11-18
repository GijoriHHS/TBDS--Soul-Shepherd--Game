extends Control


@onready var ability_icon: TextureRect = $HBoxContainer/AbilityIconButton/AbilityIcon
@onready var progress_overlay: TextureProgressBar = $HBoxContainer/AbilityIconButton/AbilityIcon/ProgressOverlay
@onready var name_label: Label = $HBoxContainer/NameLabel
@onready var info_label: Label = $HBoxContainer/IconButtonResizer/InfoLabel

signal clicked_on_a_button

var ability_name: String = ""
var ability_description: String = ""
var button_pressed : bool = true

func _ready() -> void:
	clicked_on_a_button.connect(on_button_pressed)

func set_icon(texture: Texture) -> void:
	ability_icon.texture = texture

func set_cooldown_fraction(fraction: float) -> void:
	progress_overlay.value = fraction
	

func set_info_label_text(ability: int) -> void:
	ability_description = AbilityData.INFO[ability]["description"]
	#info_label.text = ability_description
	
func set_default_info_label_text(ability: int) -> void:
	ability_name = AbilityData.INFO[ability]["name"]
	info_label.text = ability_name
	
func set_minimum_size() -> void:
	var horizontal_size = info_label.get_size().x
	print(horizontal_size)
	custom_minimum_size.x = horizontal_size *3


func _on_ability_icon_button_pressed() -> void:
	on_button_pressed()
	
func _on_label_button_pressed() -> void:
	on_button_pressed()

func on_button_pressed() -> void:
	button_pressed = !button_pressed
	
	if button_pressed:
		info_label.text = ability_name
	else:
		info_label.text = ability_description
		
