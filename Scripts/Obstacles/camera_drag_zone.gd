extends Area2D

@export var vert_drag_bottom : float
var cam : Camera2D;

func _on_body_entered(body: Node2D) -> void:
	cam = get_tree().current_scene.get_viewport().get_camera_2d()
	
	var tween = create_tween()
	if vert_drag_bottom > .2:
		cam.position_smoothing_enabled = true
		tween.tween_property(cam,"drag_bottom_margin",vert_drag_bottom,0.5)
		cam.position_smoothing_enabled = false
	else:
		tween.tween_property(cam,"drag_bottom_margin",vert_drag_bottom,.5)
