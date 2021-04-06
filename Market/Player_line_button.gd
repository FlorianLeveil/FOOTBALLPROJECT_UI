extends Panel

func _ready():
	pass # Replace with function body.


func _on_Button_pressed():
	var _player_name = get_node("name")
	_var_selected.set_selected(_player_name)
