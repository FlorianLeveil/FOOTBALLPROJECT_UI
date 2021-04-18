extends Control
onready var http : HTTPRequest = $HTTPRequest
const lbl_list = ['GK','LB','RB','CB','MC','LM','RM','CAM','LW','RW','ST']
onready var leftdropdown = get_node("Container/Nav/HBoxContainer/HBoxContainer/OptionButton")
onready var rightdropdown = get_node("Container/Nav/HBoxContainer/HBoxContainer2/OptionButton2")
var my_players = ''
var selected_player_name = ''
var selected_player = ''
var all_stats_nodes
var current_position = ''
var selected_lbl = ''

func _ready():
	rightdropdown.disabled = true
	all_stats_nodes = get_tree().get_nodes_in_group("specific_stat")
	http.request(Routes.GET_USER_PLAYERS, Routes.HEADER,false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array
	leftdropdown.add_item("Choice a position")
	for lbl in lbl_list:
		leftdropdown.add_item(lbl)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_OptionButton_item_selected(index):
	selected_player_name = ''
	clear_stats()
	rightdropdown.clear()
	if index == 0:
		rightdropdown.disabled = true
		return
	else:
		var empty = true
		var first = true
		selected_lbl = lbl_list[index -1]
		for player in my_players:
			if player["position"] == selected_lbl:
				if first:
					rightdropdown.disabled = false
					selected_player_name = player["name"]
					compute_player_stat()
					first = false
				empty = false
				rightdropdown.add_item(player["name"])
		if empty:
			rightdropdown.add_item("You don't have any player")
			rightdropdown.disabled = true

func _on_OptionButton2_item_selected(index):
	selected_player_name = rightdropdown.get_item_text(index)
	compute_player_stat()

func compute_player_stat():
	var body := {
		"player_name": selected_player_name,
	}
	http.request(Routes.GET_ONE_OF_MY_PLAYERS, Routes.HEADER,false, HTTPClient.METHOD_POST,to_json(body))
	var result := yield(http, "request_completed") as Array
	
	for node_to_set in all_stats_nodes:
		node_to_set.text = selected_player[node_to_set.name] as String
	
func clear_stats():
	for node_to_set in all_stats_nodes:
		node_to_set.text = ''

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var responce_body := JSON.parse(body.get_string_from_utf8())
	var _data = responce_body.result
	if response_code != 200:
		return
	if "my_players" in _data:
		my_players = _data.my_players	
	
	if "player" in _data:
		selected_player = _data.player



func _on_Button_pressed():
	print(selected_player_name)
	if selected_player_name == '':
		return
	else:
		var _to_return = VarSelected.get_selected_players()
		_to_return[selected_lbl] = selected_player_name
		print(_to_return[selected_lbl])
		VarSelected.set_selected_players(_to_return)
		print(VarSelected.get_selected_players())
