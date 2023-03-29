extends KinematicBody2D

export var speed = 12000

export var min_patience = 1
export var max_patience = 3

const DIRECTIONS = [Vector2.UP, Vector2.LEFT, Vector2.DOWN, Vector2.RIGHT]

var patience = (min_patience + max_patience) / 2

var direction = 0

func _physics_process(delta):
	var move = move_and_slide(DIRECTIONS[direction] * speed * delta)
	var hit = $DangerZone.get_overlapping_bodies()
	
	if hit:
		$Kill.play()
		hit[0].die()
	
	patience -= delta
	
	if not move or patience < 0:
		if patience < 0:
			patience = min_patience + randf() * (max_patience - min_patience)
		
		direction = (direction + ((randi() % 2) * 2) - 1) % len(DIRECTIONS)
		
		if DIRECTIONS[direction] == Vector2.UP:
			$Animation.play("Up")
		elif DIRECTIONS[direction] == Vector2.DOWN:
			$Animation.play("Down")
		elif DIRECTIONS[direction] == Vector2.LEFT:
			$Animation.play("Left")
		elif DIRECTIONS[direction] == Vector2.RIGHT:
			$Animation.play("Right")
