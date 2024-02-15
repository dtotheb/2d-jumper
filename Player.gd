extends CharacterBody2D



const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var HasSword = false
var myWeapon = null


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _onready():
	pass
	
	

		

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		$AnimatedSprite2D.animation = "jump"
	else:
		$AnimatedSprite2D.animation = "idle"

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	
	if Input.is_action_just_pressed("attack"):
		if myWeapon:
			myWeapon.attack()
	

	if Input.is_action_just_pressed("drop"):
		if myWeapon:
			dropWeapon()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction > 0:
		scale.x = abs(scale.x)
	elif direction < 0:
		scale.x = abs(scale.x) * -1

	$AnimatedSprite2D.play()
	
	move_and_slide()
		


func dropWeapon():
	print("drop " + str(myWeapon))
	myWeapon.reparent($/root/outside)
	myWeapon.set("PickUpAble", true)
	myWeapon.position.y -= 10
	myWeapon = null
	
func _on_weapon_pick_up(weaponPickup):
	if myWeapon == null:
		print("Picking up: " + str(weaponPickup))
		weaponPickup.set("PickUpAble", false)
		myWeapon = weaponPickup
		myWeapon.reparent($RightHand)
		#myWeapon.call_deferred("reparent", $RightHand)
		#$RightHand.call_deferred("add_child",myWeapon)
		myWeapon.position = $RightHand.position
	
