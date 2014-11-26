#
# Cookbook Name:: webservice
# Recipe:: default
#
# Copyright 2014, Gonzalo Martin
#
# All rights reserved
#

#run recipes
include_recipe 'apt::default'
include_recipe 'python::default'
include_recipe 'mongodb::default'

#set locale
bash "locale-gen" do
	user "root"
	group "root"
	code <<-EOH
		sudo locale-gen es_ES.UTF-8
		EOH
end

#install dependencies
apt_package 'python-dev' do
	action :install
	options "--force-yes"
end

apt_package 'supervisor' do
	action :install
	options "--force-yes"
end

apt_package 'htop' do
	action :install
	options "--force-yes"
end

python_pip "Flask" do
	action :install
end

python_pip "pymongo" do
	action :install
end

#supervisor configuration
template '/etc/supervisor/conf.d/webservice.conf' do
	source 'supervisor_webservice.erb'
	owner node['webservice']['root_user']
	group node['webservice']['root_group']
	mode 0644
	action :create
end

template '/etc/supervisor/supervisord.conf' do
	source 'supervisor.erb'
	owner node['webservice']['root_user']
	group node['webservice']['root_group']
	mode 0644
	action :create
	notifies :restart, 'service[supervisor]', :delayed
end

service 'supervisor' do
	supports :status => true, :start => true, :stop => true, :restart => true
	action :nothing
end
