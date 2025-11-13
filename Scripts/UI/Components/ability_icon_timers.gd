extends Control

@onready var ability_icon: TextureRect = $AbilityIconButton/AbilityIcon
@onready var progress_overlay: TextureProgressBar = $AbilityIconButton/AbilityIcon/ProgressOverlay

var ability_name: String = ""

func set_icon(texture: Texture) -> void:
	ability_icon.texture = texture

func set_cooldown_fraction(fraction: float) -> void:
	progress_overlay.value = fraction
