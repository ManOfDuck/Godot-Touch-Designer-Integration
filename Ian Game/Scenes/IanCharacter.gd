extends Sprite2D

var movementVector = Vector2(0,0)

@export var BLUMPL_SPEED = 1000;

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hello it is me blumpldorf")
	

func _input(event: InputEvent):
	# Upwards movement
	if event.is_action_pressed("up") :
		movementVector.y = -BLUMPL_SPEED
	if event.is_action_released("up"):
		if Input.is_action_pressed("down"):
			movementVector.y = BLUMPL_SPEED
		else:
			movementVector.y = 0

	#Downwards movement
	if event.is_action_pressed("down") :
		movementVector.y = BLUMPL_SPEED
	if event.is_action_released("down") :
		if Input.is_action_pressed("up"):
			movementVector.y = -BLUMPL_SPEED
		else:
			movementVector.y = 0

	#Leftwards movement
	if event.is_action_pressed("left"):
		movementVector.x = -BLUMPL_SPEED
	if event.is_action_released("left"):
		if Input.is_action_pressed("right"):
			movementVector.x = BLUMPL_SPEED
		else:
			movementVector.x = 0

	if event.is_action_pressed("right"):
		movementVector.x = BLUMPL_SPEED
	if event.is_action_released("right"):
		if Input.is_action_pressed("left"):
			movementVector.x = -BLUMPL_SPEED
		else :
			movementVector.x = 0

func _process(delta):
	self.position += movementVector * delta
	print("Hello it is me blumpldorf")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if input.isActionPressed("up"):
#		self.position.y += 1
