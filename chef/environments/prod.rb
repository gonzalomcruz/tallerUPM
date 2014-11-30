name			'prod'
description		'Production environment'

default_attributes(
	"webservice" => {
		"server_dir" => '/home/ubuntu/server',
		"user" => 'ubuntu',
		"group" => 'ubuntu'
	}
)
