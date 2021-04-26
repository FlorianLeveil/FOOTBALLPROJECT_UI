extends Control
onready var http : HTTPRequest = $HTTPRequest
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var responce_body := JSON.parse(body.get_string_from_utf8())
	var _data = responce_body.result
	if response_code != 200:
		return
	if "game_id_with_ia" in _data:
		var game_id = _data.game_id_with_ia
		VarSelected.set_game_id(game_id)
		VarSelected.set_team1(_data.team1)
		VarSelected.set_team2(_data.team2)
		var scene_path_to_load = "res://Play/MatchContainer.tscn"
		get_tree().change_scene(scene_path_to_load)	
	
	if "add_to_queue" in _data:
		http.request(Routes.GET_AN_OPPONENT , Routes.HEADER,false, HTTPClient.METHOD_GET)
		var result2 := yield(http, "request_completed") as Array
	
	if "game_id" in _data:
		if _data.game_id == "no_game":
			http.request(Routes.GET_AN_OPPONENT , Routes.HEADER,false, HTTPClient.METHOD_GET)
			var result2 := yield(http, "request_completed") as Array
		else:
			var game_id = _data.game_id
			VarSelected.set_game_id(game_id)
			var _request = Routes.GET_MY_GAME + "?game_id=" + game_id
			http.request(_request, Routes.HEADER,false, HTTPClient.METHOD_GET)
			var result2 := yield(http, "request_completed") as Array
	
	if "game" in _data:
		var _request = Routes.GET_ALL_TEAMS + "?player1_id=" + _data["game"]["player1_id"] + "&player2_id=" + _data["game"]["player2_id"]
		http.request(_request, Routes.HEADER,false, HTTPClient.METHOD_GET)
		var result3 := yield(http, "request_completed") as Array
		
	if "team" in _data:
		VarSelected.set_team1(_data.team.team1)
		VarSelected.set_team2(_data.team.team2)
		var scene_path_to_load = "res://Play/MatchContainer.tscn"
		get_tree().change_scene(scene_path_to_load)
		
func _hidden_objects(_objects,_visible):
	for _object in _objects:	
		_object.visible=_visible

func _on_OpponentBtn_pressed():
		var _the_tree = get_tree()
		get_node("HContainer/VContainer/Nav/FriendBtn").pressed=false
		get_node("HContainer/VContainer/Nav/IaBtn").pressed=false
		_hidden_objects(_the_tree.get_nodes_in_group("friend"),false)
		_hidden_objects(_the_tree.get_nodes_in_group("ia"),false)
		_hidden_objects(_the_tree.get_nodes_in_group("opponent"), true)


func _on_FriendBtn_pressed():
	var _the_tree = get_tree()
	get_node("HContainer/VContainer/Nav/IaBtn").pressed=false
	get_node("HContainer/VContainer/Nav/OpponentBtn").pressed=false
	_hidden_objects(_the_tree.get_nodes_in_group("ia"),false)
	_hidden_objects(_the_tree.get_nodes_in_group("opponent"), false)
	_hidden_objects(_the_tree.get_nodes_in_group("friend"),true)


func _on_IaBtn_pressed():
	var _the_tree = get_tree()
	get_node("HContainer/VContainer/Nav/FriendBtn").pressed=false
	get_node("HContainer/VContainer/Nav/OpponentBtn").pressed=false
	_hidden_objects(_the_tree.get_nodes_in_group("friend"),false)
	_hidden_objects(_the_tree.get_nodes_in_group("opponent"), false)
	_hidden_objects(_the_tree.get_nodes_in_group("ia"),true)



func _on_SearchBtn_pressed():
	get_node("HContainer/VContainer/OpponentContainer/lbl1").visible=false
	get_node("HContainer/VContainer/OpponentContainer/waitinglbl").visible=true
	get_node("HContainer/VContainer/Nav/FriendBtn").disabled=true
	get_node("HContainer/VContainer/Nav/IaBtn").disabled=true
	get_node("HContainer/VContainer/Nav/OpponentBtn").disabled=true
	get_node("HContainer/VContainer/HBoxContainer2/BackBtn").disabled=true
	http.request(Routes.ADD_PLAYER_TO_QUEUE , Routes.HEADER,false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array
	

func _on_PlayIABtn_pressed():
	http.request(Routes.PLAY_WITH_AN_IA , Routes.HEADER,false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array


func _on_BackBtn_pressed():
	get_node("FadeIn").show()
	get_node("FadeIn").fade_in()

func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://Menu/MainMenu.tscn")

