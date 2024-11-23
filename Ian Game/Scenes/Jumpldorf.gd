class_name Jumpldorf extends CharacterBody2D

@export var gravity = 980
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var RELEASE_IMPULSE = 200
@export var RELEASE_GRAVITY_RATIO = 0.5
@export var fallingGravityRatio = 0.5
@export var JUMPS = 2
@export var backwards_force_scale = 0.5
@export var losePosition = -10
@export var boing_velocity: Vector2 = Vector2(-5000, -1000)
@export var colordorf_fade_time: float = 2
@export var colordorf_min_speed = 35

signal i_am_dead

var jumpsRemaining = JUMPS

func do_game_manager_force(delta):
	position.x -= IanGameManager.speed * backwards_force_scale * delta

func do_animation():
	if velocity.y > 0:
		$AnimatedSprite2D.frame=3
		$Colordorf.frame=3
	elif velocity.y < -100:
		$AnimatedSprite2D.frame=2
		$Colordorf.frame=2
	elif velocity.x > 0 and is_on_floor():
		$AnimatedSprite2D.frame=1
		$Colordorf.frame=1
	elif is_on_floor():
		$AnimatedSprite2D.frame=0
		$Colordorf.frame=0


func _process(delta):
	if $Colordorf.modulate.a > 0:
		$Colordorf.modulate.a -= delta / colordorf_fade_time
	do_game_manager_force(delta)
	do_animation()
	if position.x <= losePosition:
		i_am_dead.emit()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if not Input.is_action_pressed("up"):
			velocity.y += gravity * RELEASE_GRAVITY_RATIO * delta
	else:
		jumpsRemaining = JUMPS
	
	if velocity.y < 0:
		velocity.y += gravity * fallingGravityRatio * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("up") and jumpsRemaining > 0:
		velocity.y = JUMP_VELOCITY
		#if jumpsRemaining < JUMPS:
			#$GPUParticles2D.emit_particle()
		jumpsRemaining-=1
	
	if Input.is_action_just_released("up") and not is_on_floor():
		velocity.y += RELEASE_IMPULSE
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		var speed: float = SPEED
		if $Colordorf.modulate.a > 0:
			speed = remap($Colordorf.modulate.a , 1, 0, colordorf_min_speed, SPEED)
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	position = position.clamp(Vector2.ZERO - Vector2(100,0), get_viewport_rect().size)
	move_and_slide()


func boing(color: Color) -> void:
	$Colordorf.modulate = color
	velocity = boing_velocity
