name			'dev'
description		'Developement role'

default_attributes(
	"webservice" => {
		"server_dir" => '/home/vagrant/server',
		"user" => 'vagrant',
		"group" => 'vagrant'
	}
)

run_list [
	"recipe[webservice]"
]
