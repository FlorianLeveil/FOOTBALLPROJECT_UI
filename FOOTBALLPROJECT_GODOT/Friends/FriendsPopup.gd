extends Panel
onready var http : HTTPRequest = $HTTPRequest


func _on_BackBtn_pressed():
	self.hide()

func _on_AcceptBtn_pressed():
	do_request(VarSelected.get_selected_user_email(), Routes.ACT_ACCEPT_REQUEST_FRIEND_LIST)


func _on_RejectBtn_pressed():
	do_request(VarSelected.get_selected_user_email(), Routes.ACT_REFUSE_REQUEST_FRIEND_LIST)


func _on_CancelBtn_pressed():
	do_request(VarSelected.get_selected_user_email(), Routes.ACT_CANCEL_WAITING_FRIEND_LIST)


func _on_RemoveBtn_pressed():
	do_request(VarSelected.get_selected_user_email(), Routes.ACT_REMOVE_FRIEND_LIST)


func _on_AddBtn_pressed():
	do_request(get_node("Content/MainSection/AddUserSection/EmailInput").text, Routes.ACT_ADD_FRIEND_LIST)

func do_request(email, request_route):
	var body := {
		"user_email" : email,
	}
	http.request(request_route, Routes.HEADER,false, HTTPClient.METHOD_POST, to_json(body))
	var result := yield(http, "request_completed") as Array

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var responce_body := JSON.parse(body.get_string_from_utf8())
	VarSelected.set_null()
	if response_code == 200:
		get_node("Content/ReturnMessage/Container/ReturnMessage").add_color_override("font_color",Color('#44ff00'))
		get_node("Content/ReturnMessage/Container/ReturnMessage").text='SUCCESS'
		yield(get_tree().create_timer(2.0), "timeout")
		get_node("Content/ReturnMessage/Container/ReturnMessage").text=''
		self.hide()
		get_tree().reload_current_scene()
	else:
		get_node("Content/ReturnMessage/Container/ReturnMessage").add_color_override("font_color",Color('#ff3000'))
		get_node("Content/ReturnMessage/Container/ReturnMessage").text = responce_body.result.error.capitalize()
		yield(get_tree().create_timer(2.0), "timeout")
		get_node("Content/ReturnMessage/Container/ReturnMessage").text='' 


