extends Node
#HTTP
var TOKEN = ""
var HEADER = ["Content-Type: application/json", "Authorization: Bearer " + TOKEN]

func set_token(token):
	TOKEN = token
	HEADER = ["Content-Type: application/json", "Authorization: Bearer " + TOKEN]

#AUTH
const REGISTER_URL = "http://127.0.0.1:5000/user/register"
const LOGIN_URL = "http://127.0.0.1:5000/user/login"


const GET_USER_MONEY = "http://127.0.0.1:5000/user/get_money"
const ADD_ONE_PLAYER = "http://127.0.0.1:5000/user/add_one_player"
const SELL_ONE_PLAYER = "http://127.0.0.1:5000/user/sell_one_player"
const GET_USER_PLAYERS= "http://127.0.0.1:5000/user/get_my_players"
const GET_ALL_PLAYERS = "http://127.0.0.1:5000/players"

#FRIENDS LIST
const GET_USER_FRIEND_LIST = "http://127.0.0.1:5000/user/get_friends_list"
const GET_USER_WAITING_FRIEND_LIST = "http://127.0.0.1:5000/user/get_waiting_friend_list"
const GET_USER_REQUEST_FRIEND_LIST = "http://127.0.0.1:5000/user/get_request_friend_list"
const ACT_REMOVE_FRIEND_LIST = "http://127.0.0.1:5000/user/act_rm_friend_friend_list"
const ACT_ACCEPT_REQUEST_FRIEND_LIST = "http://127.0.0.1:5000/user/act_accept_friend_request_list"
const ACT_REFUSE_REQUEST_FRIEND_LIST = "http://127.0.0.1:5000/user/act_refuse_friend_request_list"
const ACT_CANCEL_WAITING_FRIEND_LIST = "http://127.0.0.1:5000/user/act_cancel_friend_waiting_list"
const ACT_ADD_FRIEND_LIST = "http://127.0.0.1:5000/user/act_add_friend_waiting_list"

#MY TEAM
const GET_USER_PLAYERS_SELECTED_BY_POSTION = "http://127.0.0.1:5000/user/get_players_selected_by_position"
const GET_ONE_OF_MY_PLAYERS = "http://127.0.0.1:5000/user/get_one_of_my_players"
const SAVE_MY_TEAM = "http://127.0.0.1:5000/user/save_my_team"
