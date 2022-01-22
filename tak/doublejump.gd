extends Area2D


func _ready():
	$Sprite/AnimationPlayer.play("existing")


func _on_doublejump_body_entered(body):
	$Sprite/AnimationPlayer.play("hiding")
