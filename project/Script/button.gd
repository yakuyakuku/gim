extends Button

@onready var animation_player =  %AnimationPlayer

func _on_pressed():
	animation_player.play("Fire Blast")
	self.disabled = true


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	self.disabled = false
