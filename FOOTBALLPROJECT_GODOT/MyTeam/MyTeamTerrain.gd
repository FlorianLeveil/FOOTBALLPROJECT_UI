extends Control
const lbl_list = ['GK','LB','RB','CB','MC','LM','RM','CAM','LW','RW','ST']
var all_node_lbl = {'GK' : '','LB' : '','RB' :'','CB': '','MC' : '','LM' : '','RM' : '','CAM': '','LW' : '','RW':'','ST': ''}
onready var http : HTTPRequest = $HTTPRequest

# Called when the node enters the scene tree for the first time.
func _ready():
	http.request(Routes.GET_USER_PLAYERS_SELECTED_BY_POSTION , Routes.HEADER,false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array
	for lbl in lbl_list:
		var node_path = "HBoxContainer/TextureRect/" + lbl
		all_node_lbl[lbl] = get_node(node_path)
	var _selected_players = VarSelected.get_selected_players()	
	for key in all_node_lbl:
		if _selected_players[key] == "":
			all_node_lbl[key].text = "No Player"
		elif " " in _selected_players[key]:
			all_node_lbl[key].text = _selected_players[key].replace(" ", "\n")
		else:
			all_node_lbl[key].text = _selected_players[key]


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var responce_body := JSON.parse(body.get_string_from_utf8())
	if response_code != 200:
		return
	var _data = responce_body.result
	if "players_selected_by_position" in _data:
		VarSelected.set_selected_players(_data.players_selected_by_position)
