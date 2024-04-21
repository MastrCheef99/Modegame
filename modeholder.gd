extends Node2D

@export var mode = 0
@onready var character = get_node("..")
var floored
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	floored = character.floored
	if floored == true:
		if Input.is_action_just_pressed("1") && mode != 1:
			mode = 1
		if Input.is_action_just_pressed("2") && mode != 2:
			mode = 2
		if Input.is_action_just_pressed("3") && mode != 3:
			mode = 3
		if Input.is_action_just_pressed("4") && mode != 4:
			mode = 4
		if Input.is_action_just_pressed("5") && mode != 5:
			mode = 5
		if Input.is_action_just_pressed("6") && mode != 6:
			mode = 6
	if Input.is_action_just_pressed("stop"):
		mode = 0
