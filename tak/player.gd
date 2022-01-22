extends KinematicBody2D

const up = Vector2(0,-1)
const grav = 10
const maxfall = 300
const maxspeed = 60
const jump = 150
const acceleration = 6
var cd = 100
var motion = Vector2()
var facing_right = true
var shake_amount = 100.0
var landed 	
var light = true
var hint = 0
var checkpoint = Vector2(-160,8)
var doublejump = false
var doublejump_active = true

func _ready():
	pass # Replace with function body.
func _physics_process(delta):
	
	
	if motion.y <= maxfall:
		motion.y += grav
		
	if facing_right == true:
		$Sprite.scale.x = 1
		$CollisionShape2D.scale.x = 1
	else:
		$Sprite.scale.x = -1
		$CollisionShape2D.scale.x = -1
	motion.x = clamp(motion.x,-maxspeed,maxspeed)
	

		
	if Input.is_action_pressed("right"):
		motion.x += acceleration
		facing_right = true
		$AnimationPlayer.play("walk")
	elif Input.is_action_pressed("left"):
		motion.x -= acceleration
		facing_right = false
		$AnimationPlayer.play("walk")
		
	else:
		$AnimationPlayer.play("exist")
		motion.x = lerp(motion.x,0,0.2)
	
	if is_on_floor():
		doublejump_active = true
		if Input.is_action_just_pressed("jump"):
			motion.y = -jump
	
	elif is_on_wall():
		if motion.y > 0:
			motion.y = 20
		if Input.is_action_just_pressed("jump") and Input.is_action_pressed("left"):
			motion.y = -jump*0.9
			motion.x = jump*1.3
		if Input.is_action_just_pressed("jump") and Input.is_action_pressed("right"):
			motion.y = -jump*0.9
			motion.x = -jump*1.3
			
	elif doublejump == true:
		if doublejump_active == true:
			if Input.is_action_just_pressed("jump"):
				doublejump_active = false
				motion.y = -jump*0.75
				
	if Input.is_action_just_pressed("test"):
		die()
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var danger = get_parent().get_node("TileMap2")
		var checkpoint1 = get_parent().get_node("TileMap3")
		if collision.collider == danger:
			die()
		if collision.collider == checkpoint1:
				checkpoint = get_parent().get_node("player").position
	motion = move_and_slide(motion,up)
	

func die():

	
	get_tree().paused = true
	yield(get_tree().create_timer(0.4), "timeout")
	get_tree().paused = false
	get_parent().get_node("player").set_position(checkpoint)

	#get_tree().reload_current_scene()
	





func _on_Area2D_body_entered(body):
	doublejump = true
