extends Panel

var START = 0
var END = 100
var FILTERS = {
'name' : false,
'foot' : false,
'position' : false,
'league' : false,
'price' : false,
'age' : false,
'height' : false,
'overall' : false,
'crossing' : false,
'finishing' : false,
'short_passing' : false,
'volleys' : false,
'dribbling' : false,
'curve' : false,
'long_passing' : false,
'ball_control' : false,
'acceleration' : false,
'sprint_speed' : false,
'agility' : false,
'reactions' : false,
'balance' : false,
'shot_power' : false,
'strength' : false,
'long_shots' : false,
'aggression' : false,
'interceptions' : false,
'positioning' : false,
'vision' : false,
'penalties' : false,
'marking' : false,
'standing_tackle' : false,
'sliding_tackle' : false,
'gk_diving' : false,
'gk_handling' : false,
'gk_kicking' : false,
'gk_positioning' : false,
'gk_reflexes' : false,
}
const ListItem = preload("Player_line.tscn")
onready var http : HTTPRequest = $HTTPRequest


func addItem(name, foot, position, league,price, age, height,
 overall, crossing, finishing, short_passing, volleys, 
dribbling, curve, long_passing, ball_control, acceleration, 
sprint_speed, agility, reactions, balance, shot_power, 
strength, long_shots, aggression, interceptions, positioning, 
vision, penalties, marking, standing_tackle, sliding_tackle, 
gk_diving, gk_handling, gk_kicking, gk_positioning, 
gk_reflexes):
	var item = ListItem.instance()
	item.get_node("HBoxContainer/name").text = name
	item.get_node("HBoxContainer/foot").text = foot
	item.get_node("HBoxContainer/position").text = position
	item.get_node("HBoxContainer/league").text = league	
	item.get_node("HBoxContainer/price").text = price as String
	item.get_node("HBoxContainer/age").text = age as String
	item.get_node("HBoxContainer/height").text = height as String
	item.get_node("HBoxContainer/overall").text = overall as String
	item.get_node("HBoxContainer/crossing").text = crossing as String
	item.get_node("HBoxContainer/finishing").text = finishing as String
	item.get_node("HBoxContainer/short_passing").text = short_passing as String
	item.get_node("HBoxContainer/volleys").text = volleys as String
	item.get_node("HBoxContainer/volleys").text = volleys as String
	item.get_node("HBoxContainer/dribbling").text = dribbling as String
	item.get_node("HBoxContainer/curve").text = curve as String
	item.get_node("HBoxContainer/long_passing").text = long_passing as String
	item.get_node("HBoxContainer/ball_control").text = ball_control as String
	item.get_node("HBoxContainer/acceleration").text = acceleration as String
	item.get_node("HBoxContainer/sprint_speed").text = sprint_speed as String
	item.get_node("HBoxContainer/agility").text = agility as String
	item.get_node("HBoxContainer/reactions").text = reactions as String
	item.get_node("HBoxContainer/balance").text = balance as String
	item.get_node("HBoxContainer/shot_power").text = shot_power as String
	item.get_node("HBoxContainer/strength").text = strength as String
	item.get_node("HBoxContainer/long_shots").text = long_shots as String
	item.get_node("HBoxContainer/aggression").text = aggression as String
	item.get_node("HBoxContainer/interceptions").text = interceptions as String
	item.get_node("HBoxContainer/positioning").text = positioning as String
	item.get_node("HBoxContainer/vision").text = vision as String
	item.get_node("HBoxContainer/penalties").text = penalties as String
	item.get_node("HBoxContainer/marking").text = marking as String
	item.get_node("HBoxContainer/standing_tackle").text = standing_tackle as String
	item.get_node("HBoxContainer/sliding_tackle").text = sliding_tackle as String
	item.get_node("HBoxContainer/gk_diving").text = gk_diving as String
	item.get_node("HBoxContainer/gk_handling").text = gk_handling as String
	item.get_node("HBoxContainer/gk_kicking").text = gk_kicking as String
	item.get_node("HBoxContainer/gk_positioning").text = gk_positioning as String
	item.get_node("HBoxContainer/gk_reflexes").text = gk_reflexes as String
	item.rect_min_size = Vector2(1220,40)
	$ScrollContainer2/ListArea/HBoxContainer2/ScrollContainer/List_players.add_child(item)

func _ready():
	var all_buttons = get_tree().get_nodes_in_group("nav_bar")
	var START = 0
	var END = 100
	var GET_ALL_PLAYERS_100 = Routes.GET_ALL_PLAYERS + '?start=0&end=100'
	get_node("HBoxContainer3/col1/HBoxContainer/previous").disabled=true
	http.request(GET_ALL_PLAYERS_100, [],false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array
	http.request(Routes.GET_USER_MONEY, Routes.HEADER,false, HTTPClient.METHOD_GET)
	var result2 := yield(http, "request_completed") as Array
	set_function_nav_bar_buttons()

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var responce_body := JSON.parse(body.get_string_from_utf8())
	if response_code != 200:
		return
	var _data = responce_body.result
	
	if "players" in _data:
		_add_players_from_request(_data.players)
	if "money" in _data :
		_add_money_to_lbl(_data.money)
	if "my_players" in _data:
		_add_players_from_request(_data.my_players)
func _add_money_to_lbl(money):
	get_node("HBoxContainer3/col3/HBoxContainer/YourMoneylbl2").text = money as String	

func _add_players_from_request(_players):
	var lbl_no_players = get_node("ScrollContainer2/ListArea/HBoxContainer2/no_players")
	if len(_players) == 0:
		lbl_no_players.visible = true
		return 
	lbl_no_players.visible = false
	for player in _players:
		addItem(
		player.name,
		player.foot,
		player.position,
		player.league,
		player.price,
		player.age,
		player.height,
		player.overall,
		player.crossing,
		player.finishing,
		player.short_passing,
		player.volleys,
		player.dribbling,
		player.curve,
		player.long_passing,
		player.ball_control,
		player.acceleration,
		player.sprint_speed,
		player.agility,
		player.reactions,
		player.balance,
		player.shot_power,
		player.strength,
		player.long_shots,
		player.aggression,
		player.interceptions,
		player.positioning,
		player.vision,
		player.penalties,
		player.marking,
		player.standing_tackle,
		player.sliding_tackle,
		player.gk_diving,
		player.gk_handling,
		player.gk_kicking,
		player.gk_positioning,
		player.gk_reflexes)

func _on_Buy_pressed():
	var _player_to_buy_name = VarSelected.get_selected_name()
	var _player_to_buy_price = VarSelected.get_selected_price()
	var _panel_buy = get_parent().get_node("PanelBuy")
	
	if not _panel_buy.visible:
		_panel_buy.get_node("Panel/VBoxContainer/PlayerNameLbl").text = _player_to_buy_name
		_panel_buy.get_node("Panel/VBoxContainer/PriceIntLbl").text = _player_to_buy_price
		_panel_buy.show()
	print(Routes.HEADER)
	http.request(Routes.GET_USER_MONEY, Routes.HEADER,false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array
	


static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
		
func _know_filters():
	var _buttons = get_node("ScrollContainer2/ListArea/NavBar").get_children()
	for _button in _buttons:
		FILTERS[_button.name] = _button.pressed
		
func _compute_filters():
	var _to_return = ""
	for key in FILTERS:
		if FILTERS[key]:
			_to_return += "&" + key + "=1"
	return _to_return

func set_function_nav_bar_buttons():
	var all_nav_bar_buttons = get_tree().get_nodes_in_group('nav_bar')
	for button in all_nav_bar_buttons:
		button.connect("toggled", self, "_button_toggled", [button])

func _button_toggled(toggled, target):
	_know_filters()
	var _node_to_delete = get_node("ScrollContainer2/ListArea/HBoxContainer2/ScrollContainer/List_players")
	delete_children(_node_to_delete)
	var sell_mode = get_node("HBoxContainer3/col0/CheckButton").pressed
	if sell_mode:
		var _route = Routes.GET_USER_PLAYERS + "?" + _compute_filters()
		print(_route)
		http.request(_route, Routes.HEADER,false, HTTPClient.METHOD_GET)
		var result := yield(http, "request_completed") as Array
	else:
		var _request = Routes.GET_ALL_PLAYERS + "?start=" + START as String + "&end=" + END as String + _compute_filters()
		http.request(_request, [],false, HTTPClient.METHOD_GET)
		var result := yield(http, "request_completed") as Array

func _on_next_pressed():
	_know_filters()
	var _node_to_delete = get_node("ScrollContainer2/ListArea/HBoxContainer2/ScrollContainer/List_players")
	delete_children(_node_to_delete)
	END += 100
	START += 100
	if START != 0:
		get_node("HBoxContainer3/col1/HBoxContainer/previous").disabled=false
	if END == 1100:
		get_node("HBoxContainer3/col1/HBoxContainer/next").disabled=true
		
	get_node("HBoxContainer3/col1/HBoxContainer/start").text = START as String	
	get_node("HBoxContainer3/col1/HBoxContainer/end").text = END as String
	var _request = Routes.GET_ALL_PLAYERS + "?start=" + START as String + "&end=" + END as String + _compute_filters()
	http.request(_request, [],false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array
	

func _on_previous_pressed():
	_know_filters()
	var _node_to_delete = get_node("ScrollContainer2/ListArea/HBoxContainer2/ScrollContainer/List_players")
	delete_children(_node_to_delete)
	END -= 100
	START -= 100
	if START == 0:
		get_node("HBoxContainer3/col1/HBoxContainer/previous").disabled=true
	if END != 1100:
		get_node("HBoxContainer3/col1/HBoxContainer/next").disabled=false
		
	get_node("HBoxContainer3/col1/HBoxContainer/start").text = START as String	
	get_node("HBoxContainer3/col1/HBoxContainer/end").text = END as String
	var _request = Routes.GET_ALL_PLAYERS + "?start=" + START as String + "&end=" + END as String + _compute_filters()
	http.request(_request, [],false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array


func _on_CheckButton_toggled(button_pressed):
	if button_pressed == false:
		get_tree().reload_current_scene()
	else:
		var START = 0
		var END = 100
		get_node("HBoxContainer3/col1/HBoxContainer/next").disabled = true
		get_node("HBoxContainer3/col1/HBoxContainer/previous").disabled = true
		get_node("HBoxContainer3/col1/HBoxContainer/start").text = START as String	
		get_node("HBoxContainer3/col1/HBoxContainer/end").text = END as String
		
		get_node("HBoxContainer3/col2/HBoxContainer/Sell").visible=true
		get_node("HBoxContainer3/col2/HBoxContainer/Buy").visible=false
		var _node_to_delete = get_node("ScrollContainer2/ListArea/HBoxContainer2/ScrollContainer/List_players")
		delete_children(_node_to_delete)
		_know_filters()
		var _route = Routes.GET_USER_PLAYERS + "?" +  _compute_filters()
		http.request(_route, Routes.HEADER,false, HTTPClient.METHOD_GET)
		var result := yield(http, "request_completed") as Array
		http.request(Routes.GET_USER_MONEY, Routes.HEADER,false, HTTPClient.METHOD_GET)
		var result2 := yield(http, "request_completed") as Array



func _on_Sell_pressed():
	var _player_to_buy_name = VarSelected.get_selected_name()
	var _player_to_buy_price = VarSelected.get_selected_price()
	var _panel_buy = get_parent().get_node("PanelBuy")
	
	if not _panel_buy.visible:
		_panel_buy.get_node("Panel/VBoxContainer/BuyLbl").text = "SELL"
		_panel_buy.get_node("Panel/VBoxContainer/BuyLbl").add_color_override("font_color",Color('#4b6ae5'))
		_panel_buy.get_node("Panel/VBoxContainer/HBoxContainer/BuyBtn").visible = false
		_panel_buy.get_node("Panel/VBoxContainer/HBoxContainer/SellBtn").visible = true
		_panel_buy.get_node("Panel/VBoxContainer/PlayerNameLbl").text = _player_to_buy_name
		_panel_buy.get_node("Panel/VBoxContainer/PriceIntLbl").text = _player_to_buy_price
		_panel_buy.show()
	print(Routes.HEADER)
	http.request(Routes.GET_USER_MONEY, Routes.HEADER,false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array
	pass # Replace with function body.


func _on_Back_pressed():
	get_parent().get_node("FadeIn").show()
	get_parent().get_node("FadeIn").fade_in()

func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://Menu/MainMenu.tscn")

