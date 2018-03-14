# <LENOVO COPYRIGHT TO BE INSERTED>
# Cookbook Name:: lxca
# Recipe:: lxca_job
#
# Copyright 2017, LENOVO
#
# All rights reserved - Do Not Redistribute
#

lxca_job 'list_all' do
  host 'https://10.240.29.217'
  port '443'
  login_user 'USERID'
  login_password 'Passw0rd'
  verify_ssl 'NONE'
  action :discover_all
end

lxca_job 'filter_by_deviceid' do
  host 'https://10.240.29.217'
  port '443'
  login_user 'USERID'
  login_password 'Passw0rd'
  verify_ssl 'NONE'
  uuid 'F44E92339683385A8D97CD6348A6F45F'
  action :filter_by_uuid
end

lxca_job 'filter_by_jobid' do
  host 'https://10.240.29.217'
  port '443'
  login_user 'USERID'
  login_password 'Passw0rd'
  verify_ssl 'NONE'
  id '6'
  action :filter_by_id
end

lxca_job 'filter_by_state' do
  host 'https://10.240.29.217'
  port '443'
  login_user 'USERID'
  login_password 'Passw0rd'
  verify_ssl 'NONE'
  state 'Complete'
  action :filter_by_state
end

lxca_job 'cancel_job' do
  host 'https://10.240.29.217'
  port '443'
  login_user 'USERID'
  login_password 'Passw0rd'
  verify_ssl 'NONE'
  id '6'
  action :cancel_job
end

lxca_job 'delete_job' do
  host 'https://10.240.29.217'
  port '443'
  login_user 'USERID'
  login_password 'Passw0rd'
  verify_ssl 'NONE'
  id '6'
  action :delete_job
end

