#
# Cookbook Name:: bitcoin-abe
# Recipe:: default
#
# Copyright (C) 2012 Casey Link <unnamedrambler@gmail.com>
#
#
include_recipe "python::pip"
include_recipe "python::virtualenv"
include_recipe "postgresql::server"

case node['platform_family']
when "debian"
    package "python-dev"
end

python_virtualenv "#{node['bitcoin-abe']['python_dir']}" do
  action :create
end

python_pip "pycrypto" do
  virtualenv "#{node['bitcoin-abe']['python_dir']}"
  action :install
end

python_pip "psycopg2" do
  virtualenv "#{node['bitcoin-abe']['python_dir']}"
  action :install
end

execute "create-database-user" do
  command "createuser -U postgres -SDRw #{node['bitcoin-abe']['db_user']}"
  returns [0,1]
end

execute "create-database" do
  command "createdb -U postgres -O #{node['bitcoin-abe']['db_user']} #{node['bitcoin-abe']['db_name']}"
  returns [0,1]
  notifies :reload, 'service[postgresql]', :immediately
end

template "#{node['bitcoin-abe']['dir']}/abe.conf" do
  source "abe-pg.conf.erb"
  mode "666"
end

git "#{node['bitcoin-abe']['dir']}/abe" do
  repository "https://github.com/jtobey/bitcoin-abe.git"
  reference "master"
  action :sync
end

python_pip "#{node['bitcoin-abe']['dir']}/abe" do
  virtualenv "#{node['bitcoin-abe']['python_dir']}"
  action :install
  options "-e #{node['bitcoin-abe']['dir']}/abe" 
end

