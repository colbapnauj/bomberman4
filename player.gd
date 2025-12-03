extends CharacterBody2D

@export var move_speed: float = 120.0

@onready var anim = $AnimatedSprite2D

var can_put_bomb = true

var direction := Vector2.ZERO

func _physics_process(_delta):
	get_input()
	move_and_slide()
	update_animation()
	
	put_bomb()


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
	# $AnimatedSprite2D.play("death")
	
	print("❌ MORIR")
	queue_free()





func put_bomb():
	if (Input.is_action_just_pressed('tecla_x') && can_put_bomb):
		var array = get_tree().get_nodes_in_group('main')
		var newBomb = array[0].bomba.instantiate()
		newBomb.global_position = global_position
		get_tree().get_nodes_in_group('nivel')[0].add_child(newBomb)
		can_put_bomb = false
	elif (!can_put_bomb):
		check_bombs()
		
		

func check_bombs():
	var cantBombs = get_tree().get_nodes_in_group('bomba').size()
	if (cantBombs == 0):
		can_put_bomb = true
		
	


func _on_hurtbox_body_entered(body: Node2D) -> void:
	print("PLAYER BODY =", body, " grupos=", body.get_groups())
	if body.is_in_group("enemy"):
		morir()
