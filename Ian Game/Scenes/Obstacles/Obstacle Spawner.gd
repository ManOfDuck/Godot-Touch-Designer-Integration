extends Node2D
@export var scenes = []
@export var distanceBetweenObstacles: float
@export var distanceVariation: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	while true:
		spawnObstacle()
		var nextDistance = distanceBetweenObstacles + randf_range(distanceVariation.x, distanceVariation.y)
		var time = nextDistance / IanGameManager.speed
		if get_tree() != null:
			var timer = get_tree().create_timer(time)
			await timer.timeout

func spawnObstacle():
	var obstacle = scenes[randi_range(0, scenes.size()-1)]
	var instance = obstacle.instantiate()
	add_child(instance)
# Called every frame. 'delta' is the elapsed time since the previous frame.
