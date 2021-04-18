extends Control
onready var http : HTTPRequest = $HTTPRequest
#const post_list = ['Gk','Lb','Rb','Cb','Cdm','Lm','Rm','Cam','Lw','Rw','St']



onready var Gkdropdown = get_node("container/col1/GkContainer/Container/Gkdropdown")
onready var Lbdropdown = get_node("container/col1/LbContainer/Container/Lbdropdown")
onready var Rbdropdown = get_node("container/col1/RbContainer/Container/Rbdropdown")
onready var Cbdropdown = get_node("container/col1/CbContainer/Container/Cbdropdown")
onready var Mcdropdown = get_node("container/col2/McContainer/Container/Mcdropdown")
onready var Lmropdown = get_node("container/col2/LmContainer/Container/Lmdropdown")
onready var Rmdropdown = get_node("container/col2/RmContainer/Container/Rmdropdown")
onready var Camdropdown = get_node("container/col2/CamContainer/Container/Camdropdown")
onready var Lwdropdown = get_node("container/col3/LwContainer/Container/Lwdropdown")
onready var Rwdropdown = get_node("container/col3/RwContainer/Container/Rwdropdown")
onready var Stmdropdown = get_node("container/col3/StContainer/Container/Stdropdown")
onready var dropdown_list = {'GK' : Gkdropdown,'LB' : Lbdropdown,'RB' :Rbdropdown,'CB': Cbdropdown,'MC' : Mcdropdown,'LM' : Lmropdown,'RM' : Rmdropdown,'CAM': Camdropdown,'LW' : Lwdropdown,'RW': Rwdropdown,'ST': Stmdropdown}
# Called when the node enters the scene tree for the first time.

func _ready():
	http.request(Routes.GET_USER_PLAYERS_SELECTED_BY_POSTION , Routes.HEADER,false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array
	http.request(Routes.GET_USER_PLAYERS, Routes.HEADER,false, HTTPClient.METHOD_GET)
	var result2 := yield(http, "request_completed") as Array
	pass # Replace with function body.


func _add_item(my_players):
	var _selected_players = VarSelected.get_selected_players()
	var _index = 0
	for key in dropdown_list:
		if _selected_players[key] != '':
			dropdown_list[key].add_item(_selected_players[key])
		else:
			dropdown_list[key].add_item('Select a player')

	_index = 0
	for key in dropdown_list:
		for _player in my_players:
			if _player["position"] == key and not _player['name'] in _selected_players.values():
				dropdown_list[key].add_item(_player['name'])
				
				
func compute_selected_player():
	var _to_compute = VarSelected.get_selected_players()
	var _index = 0
	for key in dropdown_list:
		print(dropdown_list[key].get_item_text(dropdown_list[key].get_selected_id()))
		var _text = dropdown_list[key].get_item_text(dropdown_list[key].get_selected_id())
		if _text == 'Select a player':
			continue
		_to_compute[key] = _text
		_index += 1
	VarSelected.set_selected_players(_to_compute)
	

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var responce_body := JSON.parse(body.get_string_from_utf8())
	if response_code != 200:
		return
	var _data = responce_body.result
	if "players_selected_by_position" in _data:
		VarSelected.set_selected_players(_data.players_selected_by_position)
	if "my_players" in _data:
		_add_item(_data.my_players)


