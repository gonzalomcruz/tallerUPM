name			'prod'
description		'Production role'

default_attributes(
	"webservice" => {
		"server_dir" => '/home/ubuntu/server',
		"user" => 'ubuntu',
		"group" => 'ubuntu'
	}
)

run_list [
	"recipe[webservice]"
]
