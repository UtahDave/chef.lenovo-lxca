# <LENOVO COPYRIGHT TO BE INSERTED>
# Cookbook Name:: lxca
# Recipe:: lxca_ffdc
#
# Copyright 2017, LENOVO
#
# All rights reserved - Do Not Redistribute
#

lxca_ffdc 'filter_by_uuid' do
  host 'https://10.240.29.217'
  port '443'
  login_user 'USERID'
  login_password 'Passw0rd'
  verify_ssl 'NONE'
  uuid 'FA59C0BBC43C3C15B9D72B94AFF52B91' 
  action :filter_by_uuid
end

