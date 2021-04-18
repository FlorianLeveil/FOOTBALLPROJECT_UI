extends Control
onready var http : HTTPRequest = $HTTPRequest
const FriendLine = preload("FriendLine.tscn")
var state

func _ready():
	_on_FriendsListBtn_pressed()

func _hidden_objects(_objects,_visible):
	for _object in _objects:
		_object.visible=_visible

func _on_FriendsListBtn_pressed():
	var _node_to_delete = get_node("WindowsH/WindowsV/Content/ScrollContainer/FriendLine")
	state = 0
	delete_children(_node_to_delete)
	button_manager(state)
	get_node("WindowsH/WindowsV/NavBar/FriendRequestListBtn").pressed=false
	get_node("WindowsH/WindowsV/NavBar/WaitingListBtn").pressed=false

	http.request(Routes.GET_USER_FRIEND_LIST, Routes.HEADER,false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array
	

func _on_FriendRequestListBtn_pressed():
	state = 1
	var _node_to_delete = get_node("WindowsH/WindowsV/Content/ScrollContainer/FriendLine")
	delete_children(_node_to_delete)
	button_manager(state)
	get_node("WindowsH/WindowsV/NavBar/WaitingListBtn").pressed=false
	get_node("WindowsH/WindowsV/NavBar/FriendsListBtn").pressed=false
	http.request(Routes.GET_USER_REQUEST_FRIEND_LIST, Routes.HEADER,false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array


func _on_WaitingListBtn_pressed():
	state = 2
	var _node_to_delete = get_node("WindowsH/WindowsV/Content/ScrollContainer/FriendLine")
	delete_children(_node_to_delete)
	button_manager(state)
	get_node("WindowsH/WindowsV/NavBar/FriendRequestListBtn").pressed=false
	get_node("WindowsH/WindowsV/NavBar/FriendsListBtn").pressed=false
	http.request(Routes.GET_USER_WAITING_FRIEND_LIST, Routes.HEADER,false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array

func button_manager(state):
	if state == 0:
		_hidden_objects(get_tree().get_nodes_in_group("FriendRequestGrp"), false)
		_hidden_objects(get_tree().get_nodes_in_group("WaitingListGrp"),false)
		_hidden_objects(get_tree().get_nodes_in_group("FriendsListGrp"),true)
	elif state == 1:
		_hidden_objects(get_tree().get_nodes_in_group("FriendRequestGrp"),true)
		_hidden_objects(get_tree().get_nodes_in_group("WaitingListGrp"),false)
		_hidden_objects(get_tree().get_nodes_in_group("FriendsListGrp"),false)
	else:
		_hidden_objects(get_tree().get_nodes_in_group("FriendRequestGrp"), false)
		_hidden_objects(get_tree().get_nodes_in_group("WaitingListGrp"),true)
		_hidden_objects(get_tree().get_nodes_in_group("FriendsListGrp"),false)

func _on_AddBtn_pressed():
	var _friends_popup = get_node("FriendsPopup")
	_friends_popup.get_node("Content/TitleSection/Title").text="ADD FRIEND"
	_hidden_objects(get_tree().get_nodes_in_group("ActionsButton"), false)
	_hidden_objects(get_tree().get_nodes_in_group("AddButton"), true)
	_hidden_objects(get_tree().get_nodes_in_group("ActionsSection"), false)
	_hidden_objects(get_tree().get_nodes_in_group("AddUserSection"), true)
	_friends_popup.show()



func _on_BackBtn_pressed():
	get_node("FadeIn").show()
	get_node("FadeIn").fade_in()

func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://Menu/MainMenu.tscn")



func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	get_node("WindowsH/WindowsV/Content/NoData").visible=false
	get_node("WindowsH/WindowsV/Content/ScrollContainer").visible=true
	var responce_body := JSON.parse(body.get_string_from_utf8())
	if response_code == 200:
		var _data = responce_body.result
		if "_list" in _data:
			for user in _data._list:
				var item = FriendLine.instance()
				item.get_node("Line/Email/EmailLbl").text = user.email
				item.get_node("Line/Pseudo/PseudoLbl").text = user.pseudo
				get_node("WindowsH/WindowsV/Content/ScrollContainer/FriendLine").add_child(item)
		button_manager(state)
	else:
		get_node("WindowsH/WindowsV/Content/ScrollContainer").visible=false
		get_node("WindowsH/WindowsV/Content/NoData").visible=true
		get_node("WindowsH/WindowsV/Content/NoData").text=responce_body.result.error.capitalize()
		

static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

