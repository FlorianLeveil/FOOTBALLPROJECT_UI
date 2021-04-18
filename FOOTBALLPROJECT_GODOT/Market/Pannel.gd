extends Control
onready var http : HTTPRequest = $HTTPRequest
onready var notification : Label = $Panel/VBoxContainer/notification

func _on_BackBtn_pressed():
	self.hide()
	VarSelected.set_null()

func _on_BuyBtn_pressed():
	var body := {
		"add_one_player": VarSelected.get_selected_name(),
	}
	VarSelected.set_null()
	http.request(Routes.ADD_ONE_PLAYER, Routes.HEADER,false, HTTPClient.METHOD_POST, to_json(body))
	var result := yield(http, "request_completed") as Array


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	var responce_body := JSON.parse(body.get_string_from_ascii())
	if response_code != 200:
		notification.text = responce_body.result.error.capitalize()
		yield(get_tree().create_timer(2.0), "timeout")
		notification.text = ""
		self.hide()
	else:
		notification.text = "Well done !"
		yield(get_tree().create_timer(2.0), "timeout")
		notification.text = ""
		self.hide()
		get_tree().change_scene("res://Market/Market.tscn")


func _on_SellBtn_pressed():
	var body := {
		"sell_one_player": VarSelected.get_selected_name(),
	}
	VarSelected.set_null()
	http.request(Routes.SELL_ONE_PLAYER, Routes.HEADER,false, HTTPClient.METHOD_POST, to_json(body))
	var result := yield(http, "request_completed") as Array

