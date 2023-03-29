extends KinematicBody2D

export var speed = 20000

func _physics_process(delta):
	var moved = move_and_slide(Vector2.UP.rotated(rotation).round() * speed * delta)
	if not moved:
		get_parent().remove_child(self)
	
	var hit = $DangerZone.get_overlapping_bodies()
	
	if hit:
		$Kill.play()
		hit[0].die()
