extends AnimatedSprite

export var end_goal = 0
var opened = false

func _ready():
	hide()

func _physics_process(_delta):
	var food = get_parent().get_node("Food")
	var not_eaten = food.get_used_cells()
	
	if len(not_eaten) <= end_goal and not opened:
		$Entrance.monitorable = true
		show()
		play("Opening")
		opened = true


func _on_Elevator_animation_finished():
	play("Idle")
