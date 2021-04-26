extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var email : LineEdit = $CenterContainer/VBoxContainer/EmailEdit
onready var password : LineEdit = $CenterContainer/VBoxContainer/PasswordEdit
onready var notification : Label = $CenterContainer/VBoxContainer/Notification


func _on_Button_pressed():
	get_tree().change_scene("res://title_screen/TitleScreen.tscn")


func _on_Login_pressed():
	if email.text.empty() or password.text.empty():
		notification.text = "Please, enter your email and password"
		return
	Auth.login(email.text, password.text, http)


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	var responce_body := JSON.parse(body.get_string_from_ascii())
	if response_code != 200:
		notification.text = responce_body.result.error.capitalize()
	else:
		Routes.set_token(responce_body.result.access_token)
		VarSelected.set_my_id(responce_body.result.user_id)
		notification.text = "Sign in sucessful !"
		yield(get_tree().create_timer(2.0), "timeout")
		get_tree().change_scene("res://Menu/MainMenu.tscn")
