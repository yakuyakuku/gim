extends Button

@onready var animation_player =  %AnimationPlayer

func _on_pressed():
	animation_player.play("Nature Blast 1")
