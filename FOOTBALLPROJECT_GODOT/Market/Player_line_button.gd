extends Panel

func _on_Button_pressed():
	var _player_name = get_node("HBoxContainer/name")
	var _player_price = get_node("HBoxContainer/price")
	VarSelected.set_selected_name(_player_name)
	VarSelected.set_selected_price(_player_price)
