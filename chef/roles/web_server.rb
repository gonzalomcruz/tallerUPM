name			'web_server'
description		'Web server role'

run_list [
	"recipe[webservice]"
]
