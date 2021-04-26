extends Control

var scene_path_to_load


func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)



func _on_MyTeamBtn_pressed():
	scene_path_to_load = "res://MyTeam/MyTeam.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_MarketBtn_pressed():
	scene_path_to_load = "res://Market/Market.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_FriendsBtn_pressed():
	scene_path_to_load = "res://Friends/Friends.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_PlayBtn_pressed():
	scene_path_to_load = "res://Play/Play.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_QuitBtn_pressed():
	get_tree().quit()
