extends Control

var creditosScene = preload("res://scenes/creditos.tscn")
var opcoesScene = preload("res://scenes/opcoes.tscn")
var startScene = preload("res://scenes/Lvls/level_1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(startScene)

func _on_options_button_pressed() -> void:
	get_tree().quit()


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_packed(creditosScene)
