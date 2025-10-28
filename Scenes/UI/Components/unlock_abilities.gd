extends Control

@onready var ability_options: OptionButton = $VBoxContainer/AbilityOptions

var selected_ability

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_abilities_in_button()
	ability_options.item_selected.connect(ability_selected)
	ability_selected(0)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func add_abilities_in_button () -> void:
	if AbilityData.ability_list == null:
		print("is null")
		return
		
	for ability in AbilityData.ability_list:
		ability_options.add_item(ability)

func ability_selected (index: int) -> void:
	var selected_text = ability_options.get_item_text(index)
	print(self, selected_text)
	var selected_value: int = get_enum_from_name(selected_text)
	
	if selected_value != -1:
		selected_ability = selected_value
		
	else:
		print("Onbekende ability: ", selected_text)

	
func get_enum_from_name(ability_name: String) -> int:
	for enum_name in AbilityData.ability_list.keys():
		if enum_name == ability_name:
			return AbilityData.ability_list[enum_name]
	return -1

func _on_button_pressed() -> void:
	if not AbilityData.unlocked_abilities.has(selected_ability):
		AbilityData.unlocked_abilities.append(selected_ability)
		AbilityData.update_debug_ability_label.emit()
	else:
		print("Ability is al toegevoegd")
