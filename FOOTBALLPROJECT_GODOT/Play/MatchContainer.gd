extends Control
onready var http : HTTPRequest = $HTTPRequest
var GAME_ID = ''
var USER_ID = ''
var I_AM_PLAYER_ONE = false
var compute_player_one = false
var last_position_player_with_ball = ''
var current_score_player1 = 0
var current_score_player2 = 0
var TEAM_1 = ''
var TEAM_2 = ''
# Called when the node enters the scene tree for the first time.
func _ready():
	GAME_ID = VarSelected.get_game_id()
	USER_ID = VarSelected.get_my_id()
	TEAM_1 = VarSelected.get_team1()
	TEAM_2 = VarSelected.get_team2()
	do_request()

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var responce_body := JSON.parse(body.get_string_from_utf8())
	var _data = responce_body.result
	if response_code != 200:
		return
	if "game" in _data:
		compute_game(_data["game"])
		
func compute_game(game):
	if str(game['player1_id']) == USER_ID:
		I_AM_PLAYER_ONE = true

	if last_position_player_with_ball in ['RW', 'ST', 'LW'] and game['player_with_ball_position'] == 'MC':
		if current_score_player1 != int(game['player1_score']):
			var _nodes = get_tree().get_nodes_in_group("player_ball")
			for _node in _nodes:
				_node.visible=false
			if I_AM_PLAYER_ONE:
				get_node("VBoxContainer/HBoxContainer3/VBoxContainer/HBoxContainer2/but_for_you").visible=true
			else:
				get_node("VBoxContainer/HBoxContainer3/VBoxContainer/HBoxContainer2/but_for_opponent").visible=true
			current_score_player1 = int(game['player1_score'])
		if current_score_player2 != int(game['player2_score']):
			var _nodes = get_tree().get_nodes_in_group("player_ball")
			for _node in _nodes:
				_node.visible=false
			if I_AM_PLAYER_ONE:
				get_node("VBoxContainer/HBoxContainer3/VBoxContainer/HBoxContainer2/but_for_opponent").visible=true
			else:
				get_node("VBoxContainer/HBoxContainer3/VBoxContainer/HBoxContainer2/but_for_you").visible=true
			current_score_player2 = int(game['player2_score'])
	else:
		last_position_player_with_ball = game['player_with_ball_position']
		get_node("VBoxContainer/HBoxContainer3/VBoxContainer/HBoxContainer2/but_for_you").visible=false
		get_node("VBoxContainer/HBoxContainer3/VBoxContainer/HBoxContainer2/but_for_opponent").visible=false
		var _nodes = get_tree().get_nodes_in_group("player_ball")
		for _node in _nodes:
			_node.visible=true
		
		
	get_node("VBoxContainer/HBoxContainer3/VBoxContainer/HBoxContainer/time").text = game['time_match'] as String
	get_node("VBoxContainer/HBoxContainer2/your_score").text = game['player1_score'] as String if I_AM_PLAYER_ONE else game['player2_score']
	get_node("VBoxContainer/HBoxContainer2/opponent_score").text = game['player2_score'] as String if I_AM_PLAYER_ONE else game['player1_score']
	
	
	
	if game['player1_have_ball'] == 'True' and I_AM_PLAYER_ONE:
		var path_to_node = "VBoxContainer/HBoxContainer/Match/HBoxContainer/TextureRect/B_" + game['player_with_ball_position']
		var ball_soccer_possition = get_node(path_to_node).position
		get_node("VBoxContainer/HBoxContainer/Match/HBoxContainer/ball_soccer2").position= Vector2(ball_soccer_possition)
		get_node("VBoxContainer/HBoxContainer3/VBoxContainer/HBoxContainer2/player_with_ball").text = TEAM_1[game['player_with_ball_position']]['name'] as String
		get_node("VBoxContainer/HBoxContainer3/VBoxContainer/HBoxContainer2/player_with_ball").add_color_override("font_color",Color('#1651ee'))
	elif game['player1_have_ball'] == 'True' and not I_AM_PLAYER_ONE:
		var path_to_node = "VBoxContainer/HBoxContainer/Match/HBoxContainer/TextureRect/R_" + game['player_with_ball_position']
		var ball_soccer_possition = get_node(path_to_node).position
		get_node("VBoxContainer/HBoxContainer/Match/HBoxContainer/ball_soccer2").position= Vector2(ball_soccer_possition)
		get_node("VBoxContainer/HBoxContainer3/VBoxContainer/HBoxContainer2/player_with_ball").text = TEAM_1[game['player_with_ball_position']]['name'] as String
		get_node("VBoxContainer/HBoxContainer3/VBoxContainer/HBoxContainer2/player_with_ball").add_color_override("font_color",Color('#ff0f0f'))
	elif game['player1_have_ball'] == 'False' and not I_AM_PLAYER_ONE:
		var path_to_node = "VBoxContainer/HBoxContainer/Match/HBoxContainer/TextureRect/B_" + game['player_with_ball_position']
		var ball_soccer_possition = get_node(path_to_node).position
		get_node("VBoxContainer/HBoxContainer/Match/HBoxContainer/ball_soccer2").position= Vector2(ball_soccer_possition)
		get_node("VBoxContainer/HBoxContainer3/VBoxContainer/HBoxContainer2/player_with_ball").text = TEAM_2[game['player_with_ball_position']]['name'] as String
		get_node("VBoxContainer/HBoxContainer3/VBoxContainer/HBoxContainer2/player_with_ball").add_color_override("font_color",Color('#1651ee'))
	elif game['player1_have_ball'] == 'False' and I_AM_PLAYER_ONE:
		var path_to_node = "VBoxContainer/HBoxContainer/Match/HBoxContainer/TextureRect/R_" + game['player_with_ball_position']
		var ball_soccer_possition = get_node(path_to_node).position
		get_node("VBoxContainer/HBoxContainer/Match/HBoxContainer/ball_soccer2").position= Vector2(ball_soccer_possition)
		get_node("VBoxContainer/HBoxContainer3/VBoxContainer/HBoxContainer2/player_with_ball").text = TEAM_2[game['player_with_ball_position']]['name'] as String
		get_node("VBoxContainer/HBoxContainer3/VBoxContainer/HBoxContainer2/player_with_ball").add_color_override("font_color",Color('#ff0f0f'))
	if str(game["end"]) == 'True':
		end_of_game()
	else:
		do_request()

	
func end_of_game():
	get_node("Panel").visible=true
	if current_score_player2 == current_score_player1:
		get_node("Panel/HBoxContainer/VBoxContainer/HBoxContainer2/null").visible=true
	elif current_score_player1 > current_score_player2 and I_AM_PLAYER_ONE:
		get_node("Panel/HBoxContainer/VBoxContainer/HBoxContainer2/win").visible=true
	elif current_score_player1 < current_score_player2 and I_AM_PLAYER_ONE:
		get_node("Panel/HBoxContainer/VBoxContainer/HBoxContainer2/lose").visible=true	
	elif current_score_player1 > current_score_player2 and not I_AM_PLAYER_ONE:
		get_node("Panel/HBoxContainer/VBoxContainer/HBoxContainer2/lose").visible=true
	elif current_score_player1 < current_score_player2 and not I_AM_PLAYER_ONE:
		get_node("Panel/HBoxContainer/VBoxContainer/HBoxContainer2/win").visible=true
	var _request = Routes.DELETE_GAME + "?game_id=" + GAME_ID as String
	http.request(_request , Routes.HEADER,false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array
	GAME_ID = VarSelected.set_game_id('')
	TEAM_1 = VarSelected.set_team1('')
	TEAM_2 = VarSelected.set_team2('')
	
	
func do_request():
	var _request = Routes.GET_MY_GAME + "?game_id=" + GAME_ID as String
	http.request(_request , Routes.HEADER,false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array


func _on_quitbtn_pressed():
	get_node("FadeIn").show()
	get_node("FadeIn").fade_in()

func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://Menu/MainMenu.tscn")


