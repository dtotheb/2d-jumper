extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var MaxHealth : int = 10

var speed = -500
var facing_left = true
var Health = MaxHealth

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


func takeDamage(damage):
	Health = Health - damage
	
	if Health < 1:
		queue_free()
		
func flip():
	#velocity.x = 0
	facing_left = !facing_left
	scale.x = abs(scale.x) * -1
	
	if facing_left:
		speed = abs(speed) * -1
	else:
		speed = abs(speed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if !$RayCast2D.is_colliding() and is_on_floor():
		flip()
		
	velocity.x = speed * delta


	move_and_slide()
