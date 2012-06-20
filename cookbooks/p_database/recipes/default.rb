#
# Cookbook Name:: p_database
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "database"

mysql_database 'create prod' do
  connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  database_name 'prod'
  action :create
end
