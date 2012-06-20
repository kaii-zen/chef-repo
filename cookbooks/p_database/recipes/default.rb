#
# Cookbook Name:: p_database
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# We need those available before we attempt to install the mysql gem
%w(build-essential libmysqlclient-dev).each do |pkg|
  p = package pkg do
    action :nothing
  end
  p.run_action(:install)
end

chef_gem "mysql" do
  action :install
end

include_recipe "aws"
include_recipe "mysql::server"
include_recipe "database"

aws = data_bag_item("aws", "main")

aws_ebs_volume "data0" do
  aws_access_key aws['aws_access_key_id']
  aws_secret_access_key aws['aws_secret_access_key']
  size 10
  device '/dev/sdf'
  action [ :create, :attach ]
end

aws_ebs_volume "data1" do
  aws_access_key aws['aws_access_key_id']
  aws_secret_access_key aws['aws_secret_access_key']
  size 10
  device '/dev/sdg'
  action [ :create, :attach ]
end

aws_ebs_volume "data2" do
  aws_access_key aws['aws_access_key_id']
  aws_secret_access_key aws['aws_secret_access_key']
  size 10
  device '/dev/sdh'
  action [ :create, :attach ]
end

mysql_database 'create prod' do
  connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  database_name 'prod'
  action :create
end
