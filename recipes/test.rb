# <LENOVO COPYRIGHT TO BE INSERTED>
# Cookbook Name:: lxca
# Recipe:: lxca_config_target
#
# Copyright 2017, LENOVO
#
# All rights reserved - Do Not Redistribute
#

lxca_config_target 'filter_by_id' do
  host 'https://10.243.13.140'
  port '443'
  login_user 'USERID'
  login_password 'Passw0rd'
  verify_ssl 'NONE'
  id '54'
  action :filter_by_id
end

