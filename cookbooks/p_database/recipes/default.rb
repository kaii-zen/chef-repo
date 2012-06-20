#
# Cookbook Name:: p_database
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "build-essential" do
  action :install
end

package "libmysqlclient-dev" do
  action :install
end

chef_gem "right_aws" do
  action :install
end

chef_gem "mysql" do
  action :install
end

include_recipe "database"

mysql_database 'create prod' do
  connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  database_name 'prod'
  action :create
end
