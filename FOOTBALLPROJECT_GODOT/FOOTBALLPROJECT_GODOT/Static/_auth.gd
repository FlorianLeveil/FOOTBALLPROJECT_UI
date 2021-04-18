extends Node


func register(email: String, password: String, pseudo: String, http: HTTPRequest) -> void:
	var body := {
		"email": email,
		"password": password,
		"pseudo": pseudo,
	}
	http.request(Routes.REGISTER_URL, [], false, HTTPClient.METHOD_POST, to_json(body))
	var result := yield(http, "request_completed") as Array
	if result[1] == 200:
		pass

func login(email: String, password: String, http: HTTPRequest) -> void:
	var body := {
		"email": email,
		"password": password,
	}
	http.request(Routes.LOGIN_URL, [],false, HTTPClient.METHOD_POST, to_json(body))
	var result := yield(http, "request_completed") as Array
	if result[1] == 200:
		pass

