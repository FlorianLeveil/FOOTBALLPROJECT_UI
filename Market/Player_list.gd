extends Panel
const GET_ONE_PLAYER = "http://127.0.0.1:5000/player?name=Marqzuinhos"
const GET_ALL_PLAYERS = "http://127.0.0.1:5000/players"
var START = 0
var END = 100
var FILTERS = {
'name' : false,
'foot' : false,
'position' : false,
'league' : false,
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


func addItem(name, foot, position, league, age, height,
 overall, crossing, finishing, short_passing, volleys, 
dribbling, curve, long_passing, ball_control, acceleration, 
sprint_speed, agility, reactions, balance, shot_power, 
strength, long_shots, aggression, interceptions, positioning, 
vision, penalties, marking, standing_tackle, sliding_tackle, 
gk_diving, gk_handling, gk_kicking, gk_positioning, 
gk_reflexes):
	var item = ListItem.instance()
	item.get_node("name").text = name
	item.get_node("foot").text = foot
	item.get_node("position").text = position
	item.get_node("league").text = league
	item.get_node("age").text = age as String
	item.get_node("height").text = height as String
	item.get_node("overall").text = overall as String
	item.get_node("crossing").text = crossing as String
	item.get_node("finishing").text = finishing as String
	item.get_node("short_passing").text = short_passing as String
	item.get_node("volleys").text = volleys as String
	item.get_node("volleys").text = volleys as String
	item.get_node("dribbling").text = dribbling as String
	item.get_node("curve").text = curve as String
	item.get_node("long_passing").text = long_passing as String
	item.get_node("ball_control").text = ball_control as String
	item.get_node("acceleration").text = acceleration as String
	item.get_node("sprint_speed").text = sprint_speed as String
	item.get_node("agility").text = agility as String
	item.get_node("reactions").text = reactions as String
	item.get_node("balance").text = balance as String
	item.get_node("shot_power").text = shot_power as String
	item.get_node("strength").text = strength as String
	item.get_node("long_shots").text = long_shots as String
	item.get_node("aggression").text = aggression as String
	item.get_node("interceptions").text = interceptions as String
	item.get_node("positioning").text = positioning as String
	item.get_node("vision").text = vision as String
	item.get_node("penalties").text = penalties as String
	item.get_node("marking").text = marking as String
	item.get_node("standing_tackle").text = standing_tackle as String
	item.get_node("sliding_tackle").text = sliding_tackle as String
	item.get_node("gk_diving").text = gk_diving as String
	item.get_node("gk_handling").text = gk_handling as String
	item.get_node("gk_kicking").text = gk_kicking as String
	item.get_node("gk_positioning").text = gk_positioning as String
	item.get_node("gk_reflexes").text = gk_reflexes as String
	item.rect_min_size = Vector2(1220,40)
	$ScrollContainer2/ListArea/HBoxContainer2/ScrollContainer/List_players.add_child(item)

func _ready():
	var all_buttons = get_tree().get_nodes_in_group("nav_bar")
	
	var START = 0
	var END = 100
	var GET_ALL_PLAYERS_100 = GET_ALL_PLAYERS + '?start=0&end=100'
	get_node("HBoxContainer3/col1/HBoxContainer/previous").disabled=true
	http.request(GET_ALL_PLAYERS_100, [],false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var responce_body := JSON.parse(body.get_string_from_utf8())
	if response_code != 200:
		pass
	var _players = responce_body.result
	for player in _players.values():
		addItem(
			player.name,
			player.foot,
			player.position,
			player.league,
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
	var _player_to_buy = _var_selected.get_selected()
	_var_selected.set_null()
	var _panel_buy = get_parent().get_node("PanelBuy")
	
	if not _panel_buy.visible:
		_panel_buy.show()
	
	print(_player_to_buy)

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
	var _request = GET_ALL_PLAYERS + "?start=" + START as String + "&end=" + END as String + _compute_filters()
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
	var _request = GET_ALL_PLAYERS + "?start=" + START as String + "&end=" + END as String + _compute_filters()
	http.request(_request, [],false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array
