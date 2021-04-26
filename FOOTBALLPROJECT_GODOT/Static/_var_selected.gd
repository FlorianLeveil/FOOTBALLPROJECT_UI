extends Node

var _selected_name = ''
var _selected_price = ''
var _selected_user_email = ''
var _selected_players = {'GK' : '','LB' : '','RB' :'','CB': '','MC' : '','LM' : '','RM' : '','CAM': '','LW' : '','RW':'','ST': ''}
var _team1 = {'GK' : '','LB' : '','RB' :'','CB': '','MC' : '','LM' : '','RM' : '','CAM': '','LW' : '','RW':'','ST': ''}
var _team2 = {'GK' : '','LB' : '','RB' :'','CB': '','MC' : '','LM' : '','RM' : '','CAM': '','LW' : '','RW':'','ST': ''}
var _game_id = ''
var _my_id = ''

func set_selected_name(selected):
	_selected_name = selected
	
func set_my_id(my_id):
	_my_id = my_id


func set_team1(team1):
	_team1 = team1
	

func set_team2(team2):
	_team2 = team2


func get_team1():
	return _team1
	

func get_team2():
	return _team2


func get_my_id():
	return _my_id
	
func set_selected_price(selected):
	_selected_price = selected


func set_selected_user_email(selected):
	_selected_user_email = selected
	
	
func set_selected_players(selected):
	_selected_players = selected
	
	
func set_game_id(game_id):
	_game_id = game_id
	
func get_selected_name():
	if _selected_name:
		return _selected_name.text
	else:
		return ''
		
func get_selected_price():
	if _selected_price:
		return _selected_price.text
	else:
		return ''
		
func get_game_id():
	return _game_id		
		
func get_selected_user_email():
	return _selected_user_email


func get_selected_players():
	return _selected_players

func set_null():
	_selected_name = ''
	_selected_price = ''
	_selected_user_email = ''
