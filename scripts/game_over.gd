extends Control

var mainMenuScene = load("res://scenes/main_menu.tscn")
var levelPath: String = str("res://scenes/" + GameGlobals.level[GameGlobals.levelIndex] + ".tscn")
var level = load(levelPath)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_try_again_button_pressed() -> void:
	get_tree().change_scene_to_packed(level)


func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_packed(mainMenuScene)
