extends Control

const REGISTER_URL = "http://127.0.0.1:5000/user/register"
const GET_ONE_PLAYER = "http://127.0.0.1:5000/player?name=Marqzuinhos"
const GET_ALL_PLAYERS = "http://127.0.0.1:5000/players?name=Marqzuinhos"
onready var http : HTTPRequest = $HTTPRequest

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var responce_body := JSON.parse(body.get_string_from_ascii())
	print(body.get_string_from_utf8())


func idk() -> void:
	http.request(GET_ONE_PLAYER, [],false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array



func _on_MyTeamBtn_pressed():
	idk()
