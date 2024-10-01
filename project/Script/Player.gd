extends CharacterBody2D

var is_hyperspeed : bool = false
@export var speed : float = 100
@export var run_speed : float = 150
@export var hyperspeed : float = 400

@onready var anim_sprite = $AnimatedSprite2D
var last_direction : Vector2 = Vector2.ZERO

func _physics_process(_delta):
	var direction : Vector2 = Input.get_vector("left", "right", "up", "down").normalized()
	var current_speed = hyperspeed if is_hyperspeed else (run_speed if Input.is_action_pressed("run") else speed)
	
	if Input.is_action_just_pressed("hyperspeed"):
		is_hyperspeed = true
		get_tree().create_timer(5.0).connect("timeout", Callable(self, "_on_hyperspeed_timeout"))
	
	if direction.x != 0 and direction.y != 0:
		if abs(direction.x) > abs(direction.y):
			direction.y = 0
		else:
			direction.x = 0
	
	if direction != Vector2.ZERO:
		last_direction = direction
		if direction.y < 0 and anim_sprite.animation != "up":
			anim_sprite.play("up")
		elif direction.y > 0 and anim_sprite.animation != "down":
			anim_sprite.play("down")
		if direction.x < 0 and anim_sprite.animation != "left":
			anim_sprite.play("left")
		elif direction.x > 0 and anim_sprite.animation != "right":
			anim_sprite.play("right")
	else:
		if last_direction.y < 0:
			anim_sprite.play("idle_up")
		elif last_direction.y > 0:
			anim_sprite.play("idle_down")
		elif last_direction.x < 0:
			anim_sprite.play("idle_left")
		elif last_direction.x > 0:
			anim_sprite.play("idle_right")
	
	if direction:
		velocity = direction * current_speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func _on_hyperspeed_timeout():
	is_hyperspeed = false
