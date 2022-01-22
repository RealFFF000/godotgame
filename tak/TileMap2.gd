extends TileMap


func _ready():
	pass



func _on_skucha_body_entered(body):
	body.die();
