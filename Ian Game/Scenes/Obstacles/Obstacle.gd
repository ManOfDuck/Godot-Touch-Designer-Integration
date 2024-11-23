class_name Obstacle extends StaticBody2D

@export var speed_scale: float = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= IanGameManager.speed * delta * speed_scale
