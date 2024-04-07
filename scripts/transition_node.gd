extends CanvasLayer

enum TransitionMode {
	ENTER_ANIMATION,
	EXIT_ANIMATION,
}

@export var animation_mode: TransitionMode

@onready var animation_player: AnimationPlayer = $animation_player

func _ready() -> void:
	match animation_mode:
		TransitionMode.ENTER_ANIMATION:
			animation_player.play("transition_in")
		
		TransitionMode.EXIT_ANIMATION:
			animation_player.play("transition_out")
