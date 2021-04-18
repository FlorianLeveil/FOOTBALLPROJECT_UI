extends Panel


func _on_DelBtn_pressed():
	_hidden_objects(get_tree().get_nodes_in_group("ActionsButton"), false)
	_hidden_objects(get_tree().get_nodes_in_group("RemoveButton"), true)
	_hidden_objects(get_tree().get_nodes_in_group("AddUserSection"), false)
	_hidden_objects(get_tree().get_nodes_in_group("ActionsSection"), true)
	VarSelected.set_selected_user_email(get_node("Line/Email/EmailLbl").text)
	get_tree().get_nodes_in_group("FriendsPopup")[0].visible=true
	get_tree().get_nodes_in_group("ActionsSection")[0].visible=true
	get_tree().get_nodes_in_group("ActionsSectionMessage")[0].text="Are you sur to delete this user ?"
	get_tree().get_nodes_in_group("Title")[0].text="Delete user"
		
func _on_AcceptBtn_pressed():
	_hidden_objects(get_tree().get_nodes_in_group("ActionsButton"), false)
	_hidden_objects(get_tree().get_nodes_in_group("AcceptButton"), true)
	_hidden_objects(get_tree().get_nodes_in_group("AddUserSection"), false)
	_hidden_objects(get_tree().get_nodes_in_group("ActionsSection"), true)
	VarSelected.set_selected_user_email(get_node("Line/Email/EmailLbl").text)
	get_tree().get_nodes_in_group("FriendsPopup")[0].visible=true
	get_tree().get_nodes_in_group("ActionsSection")[0].visible=true
	get_tree().get_nodes_in_group("ActionsSectionMessage")[0].text="Are you sur to accept this user in your friend ?"
	get_tree().get_nodes_in_group("Title")[0].text="Accept user request"	
	
func _on_RejectBtn_pressed():
	_hidden_objects(get_tree().get_nodes_in_group("ActionsButton"), false)
	_hidden_objects(get_tree().get_nodes_in_group("RejectButton"), true)
	_hidden_objects(get_tree().get_nodes_in_group("AddUserSection"), false)
	_hidden_objects(get_tree().get_nodes_in_group("ActionsSection"), true)
	VarSelected.set_selected_user_email(get_node("Line/Email/EmailLbl").text)
	get_tree().get_nodes_in_group("FriendsPopup")[0].visible=true
	get_tree().get_nodes_in_group("ActionsSection")[0].visible=true
	get_tree().get_nodes_in_group("ActionsSectionMessage")[0].text="Are you sur to reject this user in your friend ?"
	get_tree().get_nodes_in_group("Title")[0].text="Reject user request"
	
func _on_CancelBtn_pressed():
	_hidden_objects(get_tree().get_nodes_in_group("ActionsButton"), false)
	_hidden_objects(get_tree().get_nodes_in_group("CancelButton"), true)
	_hidden_objects(get_tree().get_nodes_in_group("AddUserSection"), false)
	_hidden_objects(get_tree().get_nodes_in_group("ActionsSection"), true)
	VarSelected.set_selected_user_email(get_node("Line/Email/EmailLbl").text)
	get_tree().get_nodes_in_group("FriendsPopup")[0].visible=true
	get_tree().get_nodes_in_group("ActionsSection")[0].visible=true
	get_tree().get_nodes_in_group("ActionsSectionMessage")[0].text="Are you sur to cancel your request to this user?"
	get_tree().get_nodes_in_group("Title")[0].text="Cancel request"
		
func _hidden_objects(_objects,_visible):
	for _object in _objects:
		_object.visible=_visible
