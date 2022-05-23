extends Spatial

const SPEED = 10

func _ready():
	pass

func _process(delta):
	var vel = Vector3.ZERO
	if Input.is_action_pressed("ui_left"):
		vel += Vector3.LEFT
	if Input.is_action_pressed("ui_right"):
		vel += Vector3.RIGHT
	if Input.is_action_pressed("ui_up"):
		vel += Vector3.FORWARD
	if Input.is_action_pressed("ui_down"):
		vel += Vector3.BACK
	if Input.is_action_pressed("up"):
		vel += Vector3.UP
	if Input.is_action_pressed("down"):
		vel += Vector3.DOWN
		
	self.translate(vel.normalized() * delta * SPEED)
