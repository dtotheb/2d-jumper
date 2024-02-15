extends Node2D

@export var PickUpAble: bool = false
@export var Damage: int = 2
@export var SwingSpeed: float = 1.0
signal PickUp( weapon )
var ActiveAttack = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func attack():
	ActiveAttack = true

func swingSword(_delta):
	if ActiveAttack:
		rotation = rotation + ( deg_to_rad(5) * SwingSpeed)
		if rotation >= deg_to_rad(180):
			ActiveAttack = false
			rotation = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ActiveAttack:
		swingSword(delta)

func _on_area_2d_body_entered(body):
	if body.get_name() == "Player":
		_on_Pickup()
	elif body.get_name().contains("Enemy"):
		if ActiveAttack:
			body.takeDamage(Damage)
		
func _on_Pickup():
		if PickUpAble:
			emit_signal("PickUp", self)
