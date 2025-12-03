extends CharacterBody2D

@export var speed: float = 40

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var directions = [
	Vector2.UP,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.RIGHT
]

var direction: Vector2 = Vector2.ZERO

func _ready():
	randomize()
	choose_new_direction()

func _physics_process(delta):
	velocity = direction * speed

	var collision = move_and_collide(velocity * delta)

	if collision:
		choose_new_direction()

	play_animation_by_direction()


func choose_new_direction():
	var old = direction
	while direction == old:
		direction = directions.pick_random()


func play_animation_by_direction():
	if direction == Vector2.DOWN:
		sprite.play("walk_down")
	elif direction == Vector2.UP:
		sprite.play("walk_up")
	elif direction == Vector2.LEFT:
		sprite.play("walk_left")
	elif direction == Vector2.RIGHT:
		sprite.play("walk_right")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.morir()
