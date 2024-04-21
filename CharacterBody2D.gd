extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -250.0
@export var bounce_velocity = -350.0
@export var high_jump_velocity = -450.0
@export var gravity = 400
@export var floored = false
@onready var modeholder = get_node("modeholder")
var mode
var falldamage = false
var waterentered = false
var swimforce = -200.0
var swimgrav = 6500.0

func _physics_process(delta):
	mode = modeholder.mode
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if is_on_floor():
		floored = true
	if not is_on_floor():
		floored = false
	
	if mode == 1:
		set_collision_layer_value(2, false)
		set_collision_mask_value(2, false)
	else:
		set_collision_layer_value(2, true)
		set_collision_mask_value(2, true)
	if mode == 2:
		set_collision_layer_value(3, true)
		set_collision_mask_value(3, true)
	else:
		set_collision_layer_value(3, false)
		set_collision_mask_value(3, false)
	if mode == 3 && is_on_floor():
		velocity.y += bounce_velocity
	if mode == 5 && waterentered == true && Input.is_action_just_pressed("jump"):
		velocity.y = swimforce
	if mode == 6 && is_on_floor() && Input.is_action_just_pressed("jump"):
		velocity.y += high_jump_velocity
	if mode == 6 && velocity.y >= 550:
		falldamage = true
	if mode == 6 && falldamage == true && is_on_floor():
		print("you took fall damage")
		falldamage = false
	
	if waterentered==true:
		gravity = swimgrav
	if waterentered==false:
		gravity = 400
	
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	move_and_slide()

func _on_area_2d_body_entered(body):
	waterentered = true


func _on_area_2d_body_exited(body):
	waterentered = false
