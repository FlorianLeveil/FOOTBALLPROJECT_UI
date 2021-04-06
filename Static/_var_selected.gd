extends Node

var _selected = ''

func set_selected(selected):
	_selected = selected
	
func get_selected():
	if _selected:
		return _selected.text
	else:
		return ''

func set_null():
	_selected = ''
