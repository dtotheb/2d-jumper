extends Node2D
signal PickUp


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	print("sword")
	emit_signal("PickUp") # Replace with function body.
	call_deferred("free")
