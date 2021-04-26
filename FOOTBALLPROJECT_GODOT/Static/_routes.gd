extends Node
#HTTP
var TOKEN = ""
var HEADER = ["Content-Type: application/json", "Authorization: Bearer " + TOKEN]
const SERVER_ADRESS =  "http://127.0.0.1:5000"

func set_token(token):
	TOKEN = token
	HEADER = ["Content-Type: application/json", "Authorization: Bearer " + TOKEN]

#AUTH
const REGISTER_URL = SERVER_ADRESS + "/user/register"
const LOGIN_URL = SERVER_ADRESS + "/user/login"


const GET_USER_MONEY = SERVER_ADRESS + "/user/get_money"
const ADD_ONE_PLAYER = SERVER_ADRESS + "/user/add_one_player"
const SELL_ONE_PLAYER = SERVER_ADRESS + "/user/sell_one_player"
const GET_USER_PLAYERS= SERVER_ADRESS + "/user/get_my_players"
const GET_ALL_PLAYERS = SERVER_ADRESS + "/players"

#FRIENDS LIST
const GET_USER_FRIEND_LIST = SERVER_ADRESS + "/user/get_friends_list"
const GET_USER_WAITING_FRIEND_LIST = SERVER_ADRESS + "/user/get_waiting_friend_list"
const GET_USER_REQUEST_FRIEND_LIST = SERVER_ADRESS + "/user/get_request_friend_list"
const ACT_REMOVE_FRIEND_LIST = SERVER_ADRESS + "/user/act_rm_friend_friend_list"
const ACT_ACCEPT_REQUEST_FRIEND_LIST = SERVER_ADRESS + "/user/act_accept_friend_request_list"
const ACT_REFUSE_REQUEST_FRIEND_LIST = SERVER_ADRESS + "/user/act_refuse_friend_request_list"
const ACT_CANCEL_WAITING_FRIEND_LIST = SERVER_ADRESS + "/user/act_cancel_friend_waiting_list"
const ACT_ADD_FRIEND_LIST = SERVER_ADRESS + "/user/act_add_friend_waiting_list"

#MY TEAM
const GET_USER_PLAYERS_SELECTED_BY_POSTION = SERVER_ADRESS + "/user/get_players_selected_by_position"
const GET_ONE_OF_MY_PLAYERS = SERVER_ADRESS + "/user/get_one_of_my_players"
const SAVE_MY_TEAM = SERVER_ADRESS + "/user/save_my_team"


#PLAY
const PLAY_WITH_AN_IA = SERVER_ADRESS + "/gamemanager/play_with_a_ia"
const GET_MY_GAME = SERVER_ADRESS + "/gamemanager/get_my_game"
const GET_ALL_TEAMS = SERVER_ADRESS + "/gamemanager/get_all_teams"
const ADD_PLAYER_TO_QUEUE = SERVER_ADRESS + "/gamemanager/add_player_to_queue"
const GET_AN_OPPONENT = SERVER_ADRESS + "/gamemanager/get_an_opponent"
const DELETE_GAME = SERVER_ADRESS + "/gamemanager/delete_game"
