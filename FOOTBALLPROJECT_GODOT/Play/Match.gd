extends Control
onready var http : HTTPRequest = $HTTPRequest


var GAME_ID = ''
var USER_ID = ''

# Called when the node enters the scene tree for the first time.
func _ready():
	GAME_ID = VarSelected.get_game_id()
	USER_ID = VarSelected.get_my_id()

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var responce_body := JSON.parse(body.get_string_from_utf8())
	var _data = responce_body.result
	if response_code != 200:
		return
	if "game_id" in _data:
		var game = _data.game_id
		

func do_request():
	var _request = Routes.GET_MY_GAME + "?game_id=" + GAME_ID as String
	http.request(_request , Routes.HEADER,false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array
