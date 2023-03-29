extends KinematicBody2D

var direction = Vector2(0,0)
export var speed = 12000
var dead = false
var death_timer = 0
export var downtime = 1.5
var loaded = false
onready var bullet_path = preload("res://Bullet.tscn")

func _input(event):
	if dead:
		return

	if event.is_action_pressed("p1_up"):
		direction = Vector2(0,-1)
		$Rotating.rotation_degrees = 0
	if event.is_action_pressed("p1_down"):
		direction = Vector2(0,1)
		$Rotating.rotation_degrees = 180
	if event.is_action_pressed("p1_left"):
		direction = Vector2(-1,0)
		$Animation.play("Left")
		$Rotating.rotation_degrees = -90
	if event.is_action_pressed("p1_right"):
		direction = Vector2(1,0)
		$Animation.play("Right")
		$Rotating.rotation_degrees = 90
	if event.is_action_pressed("p1_shoot"):
		if loaded:
			shoot()

func _physics_process(delta):
	if dead:
		death_timer += delta
		if death_timer > downtime:
			dead = false
			collision_layer = 4
			$Animation.play("Up")
		else:
			return

	move_and_slide(direction * speed * delta)

	var bodies = $Ingestion.get_overlapping_bodies()
	if bodies:
		var items = bodies[0]
		var hit = $Rotating/ShotPossition.global_position
		var pos = items.world_to_map(hit / 3)
		var atlas = items.get_cellv(pos)
		var tile = items.get_cell_autotile_coord(pos.x, pos.y)
		
		items.set_cellv(pos, -1)
		
		if atlas > -1:
			if tile == Vector2(0, 0):
				$SoundPellet.play()
				ScoreKeeping.P1_Points += 1
			elif tile == Vector2(1, 0):
				$SoundStrawberry.play()
				ScoreKeeping.P1_Points += 3
				loaded = true

	var P1score = get_parent().get_node("LevelGUI/Player1Score")
	P1score.text = str(ScoreKeeping.P1_Points)

	var leaving = $Leaver.get_overlapping_areas()

	if leaving:

		var currentLevel = get_tree().get_current_scene().get_name()

		if currentLevel == "TestLevel":
			get_tree().change_scene("res://OpenLevel.tscn")
		if currentLevel == "OpenLevel":
			get_tree().change_scene("res://BaseLevel.tscn")
		if currentLevel == "BaseLevel":
			get_tree().change_scene("res://MazeLevel.tscn")
		if currentLevel == "MazeLevel":
			get_tree().change_scene("res://VictoryScreen.tscn")
	
	if loaded:
		get_parent().get_node("LevelGUI/Player1Indicator").color = Color(0.94902, 0.243137, 0.243137)
	else:
		get_parent().get_node("LevelGUI/Player1Indicator").color = Color(0, 0, 0)

func die() -> void:
	dead = true
	collision_layer = 0
	$Animation.play("Lose")
	death_timer = 0

func shoot() -> void:
	loaded = false
	var bullet = bullet_path.instance()
	get_parent().add_child(bullet)
	bullet.global_position = $Rotating/ShotPossition.global_position
	bullet.rotation = $Rotating.rotation
