extends VehicleBody

const STEER_SPEED = 1
const STEER_LIMIT = 0.4

var steer_target = 0

export var engine_force_value = 40

func _physics_process(delta):
	var fwd_mps = transform.basis.xform_inv(linear_velocity).x

	steer_target = Input.get_action_strength("turn_left") - Input.get_action_strength("turn_right")
	steer_target *= STEER_LIMIT

	if $go.pressed:
		engine_force = engine_force_value
	else:
		engine_force = 0

	if $back.pressed:
		if (fwd_mps >= -1):
			engine_force = -engine_force_value
		else:
			brake = 1
	else:
		brake = 0.0

	steering = move_toward(steering, steer_target, STEER_SPEED * delta)
	if $camera_button.pressed:
		$Camera.current = false
		$Camera2.current = true
		$camera_button.hide()
		$camera_button2.show()
	if $camera_button2.pressed:
		$Camera.current = true
		$Camera2.current = false
		$camera_button.show()
		$camera_button2.hide()
