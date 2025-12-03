extends CharacterBody2D

@export var move_speed: float = 120.0

@onready var anim = $AnimatedSprite2D

var direction := Vector2.ZERO

func _physics_process(_delta):
	get_input()
	move_and_slide()
	update_animation()
	


func get_input():
	direction = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x = 1
	elif Input.is_action_pressed("ui_left"):
		direction.x = -1
	
	if Input.is_action_pressed("ui_down"):
		direction.y = 1
	elif Input.is_action_pressed("ui_up"):
		direction.y = -1

	# normalizamos para que no corra más rápido en diagonal
	direction = direction.normalized()
	velocity = direction * move_speed


func update_animation():
	if direction == Vector2.ZERO:
		anim.play("idle")
		return

	if direction.x > 0:
		anim.play("right")
	elif direction.x < 0:
		anim.play("left")
	elif direction.y < 0:
		anim.play("up")
	elif direction.y > 0:
		anim.play("down")
		
func morir():
	queue_free()







	
	
	
