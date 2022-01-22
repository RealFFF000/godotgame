extends Sprite


func _ready():
	pass

func _on_PlayerDetector_body_entered(body):
	body.die()


