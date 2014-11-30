name			'dev'
description		'Developement environment'

default_attributes(
	"webservice" => {
		"server_dir" => '/home/vagrant/server',
		"user" => 'vagrant',
		"group" => 'vagrant'
	}
)
