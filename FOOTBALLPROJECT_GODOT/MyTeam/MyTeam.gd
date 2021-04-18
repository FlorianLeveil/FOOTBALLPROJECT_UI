extends Control
onready var http : HTTPRequest = $HTTPRequest


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	http.request(Routes.GET_USER_PLAYERS_SELECTED_BY_POSTION , Routes.HEADER,false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array
	get_node("VBoxContainer/HBoxContainer/GeneralBtn").pressed=true

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var responce_body := JSON.parse(body.get_string_from_utf8())
	if response_code != 200:
		return
	var _data = responce_body.result




func _on_SaveBtn_pressed():
	if 	get_node("VBoxContainer/HBoxContainer3/MyteamPlayerList").visible:
		get_node("VBoxContainer/HBoxContainer3/MyteamPlayerList").compute_selected_player()

	var body := {
		"_selected_players": VarSelected.get_selected_players(),
	}
	http.request(Routes.SAVE_MY_TEAM, Routes.HEADER,false, HTTPClient.METHOD_POST, to_json(body))
	var result := yield(http, "request_completed") as Array
	if result[1] == 200:
		get_tree().reload_current_scene()


func _on_SpecificBtn_pressed():
	get_node("VBoxContainer/HBoxContainer/GeneralBtn").pressed=false
	get_node("VBoxContainer/HBoxContainer/SpecificBtn").pressed=true
	get_node("VBoxContainer/HBoxContainer3/MyteamPlayerList").visible=false
	get_node("VBoxContainer/HBoxContainer3/MyTeamSpecific").visible=true

func _on_GeneralBtn_pressed():
	get_node("VBoxContainer/HBoxContainer/SpecificBtn").pressed=false
	get_node("VBoxContainer/HBoxContainer/GeneralBtn").pressed=true
	get_node("VBoxContainer/HBoxContainer3/MyTeamSpecific").visible=false
	get_node("VBoxContainer/HBoxContainer3/MyteamPlayerList").visible=true


func _on_BackBtn_pressed():
	get_node("FadeIn").show()
	get_node("FadeIn").fade_in()

func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://Menu/MainMenu.tscn")


