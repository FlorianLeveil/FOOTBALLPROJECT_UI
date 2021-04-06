extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var email : LineEdit = $CenterContainer/VBoxContainer/EmailEdit
onready var password : LineEdit = $CenterContainer/VBoxContainer/PasswordEdit
onready var pseudo : LineEdit = $CenterContainer/VBoxContainer/PseudoEdit
onready var notification : Label = $CenterContainer/VBoxContainer/Notification

func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	var responce_body := JSON.parse(body.get_string_from_ascii())
	if response_code != 200:
		notification.text = responce_body.result.error.capitalize()
	else:
		notification.text = "Registration sucessful !"
		yield(get_tree().create_timer(2.0), "timeout")
		get_tree().change_scene("res://Login/Login.tscn")

func _on_Register_pressed() -> void:
	if email.text.empty()  or password.text.empty() or pseudo.text.empty():
		notification.text = "Invalid email, password or pseudo !"
		return
	Auth.register(email.text, password.text, pseudo.text ,http)


func _on_Button_pressed():
	get_tree().change_scene("res://title_screen/TitleScreen.tscn")
