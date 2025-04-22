extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -800.0
const GROUND_FRICTION = 0.09
const AIR_RESIST = 0.9
const GRAVITY = 1800

var falling = false
var jumping  = false

var coyote_frames = 6
var coyote = false
var last_floor = false

var jump_counter = 0
var max_jumps = 1

var axe_gotten = false
var double_jump_got = false
var hover_got = false

# things to implement:
# hover


func _physics_process(delta):
	
	# movement code
	
	# gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		falling = true
		
	if is_on_floor():
		jump_counter = 0
		
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote or max_jumps > jump_counter):
		velocity.y = JUMP_VELOCITY*(0.7**jump_counter)
		jumping = true
		jump_counter += 1
	
	# direction
	var direction = Input.get_axis("left", "right")
	
	if direction:
		$sprite.scale.x = -direction
		velocity.x = direction * SPEED
	else:
			if is_on_floor():
				velocity.x = move_toward(velocity.x, 0, SPEED * GROUND_FRICTION)
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED * AIR_RESIST * delta)
	
	last_floor = is_on_floor()

	move_and_slide()
	
	# handle coyote jump
	if !is_on_floor() and last_floor and !jumping:
		coyote = true
		$coyoteTimer.start()
		print("coyote jump")
	


func _on_coyote_timer_timeout():
	coyote = false
	

func _on_dialogue_box_got_axe():
	axe_gotten = true


func _on_dialogue_box_got_double_jump():
	max_jumps = 2
	double_jump_got = true


func _on_dialogue_box_got_hover():
	hover_got = true
