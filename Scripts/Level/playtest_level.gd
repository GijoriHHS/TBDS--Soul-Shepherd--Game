extends Node2D

@export var carried_abilities: AbilityUnlocking
@onready var key_1: Trigger = $Events/Key1
@onready var obstacle_spike_2: Area2D = $Obstacles/obstacle_spike2
@onready var tile_map: TileMap = $TileMap

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var obstacles: Node2D = $Obstacles
	print(obstacles)
	CheckPointManager.register_root_obstacle(obstacles)
	add_carried_abilities()
	KeyManager.boss_death.connect(_on_boss_defeated)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_carried_abilities():
	if not carried_abilities or carried_abilities.unlocked_abilities.is_empty():
		pass
	else:
		for ability in carried_abilities.unlocked_abilities:
			AbilityData.add_collected_ability_add_to_list(ability)
			
func _on_boss_defeated():
	print("in level script")
	key_1.position = Vector2(255, 180)
	obstacle_spike_2.queue_free()
	tile_map.erase_cell(0, Vector2i(32,16))
	tile_map.erase_cell(0, Vector2i(32,17))
