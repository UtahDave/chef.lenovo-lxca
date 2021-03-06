################################################################################
# Lenovo Copyright
#
# (c) Copyright Lenovo 2017.
#
# LIMITED AND RESTRICTED RIGHTS NOTICE:
# If data or software is delivered pursuant a General Services
# Administration (GSA) contract, use, reproduction, or disclosure
# is subject to restrictions set forth in Contract No. GS-35F-05925.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################
require 'pp'

resource_name :lxca_node
provides :lxca_node

property :host, String, required: true
property :port, String, required: true
property :login_user, String, required: true
property :login_password, String, required: true
property :verify_ssl, String, required: true
property :auth_type, String, default: 'basic_auth'
property :csrf_token, String
property :uuid, String
property :chassis, String
property :media_type, String
property :media_uid, String
property :opts, Hash

action_class do
  def create_client
    require 'xclarity_client'

    conf=XClarityClient::Configuration.new(
      :username => new_resource.login_user,
      :password => new_resource.login_password,
      :host => new_resource.host,
      :port => new_resource.port,
      :auth_type => new_resource.auth_type,
      :verify_ssl => new_resource.verify_ssl
    )

    @client = XClarityClient::Client.new(conf)
  end
end

action :discover_all do
  create_client if @client.nil?
  @client.discover_nodes.map do |node|
    node.instance_variables.each do |att|
      puts "#{att} - #{node.instance_variable_get att}"
    end
  end
end

action :discover_managed do
  create_client if @client.nil?
  @client.discover_nodes({:status => 'managed'}).map do |node|
    node.instance_variables.each do |att|
      puts "#{att} - #{node.instance_variable_get att}"
    end
  end
end
  
action :discover_unmanaged do
    create_client if @client.nil?
    @client.discover_nodes({:status => 'unmanaged'}).map do |node|
      node.instance_variables.each do |att|
        puts "#{att} - #{node.instance_variable_get att}"
      end
    end
  end

action :filter_by_chassis do
  create_client if @client.nil?
  if new_resource.chassis.nil?
    Chef::Log.fatal("Attribute chassis is mandatory for the action filter_by_chassis")
  end
  @client.discover_nodes({:chassis => "#{new_resource.chassis}"}).map do |node|
    node.instance_variables.each do |att|
      puts "#{att} - #{node.instance_variable_get att}"
    end
  end
end

action :filter_by_uuid do
  create_client if @client.nil?
  if new_resource.uuid.nil?
    Chef::Log.fatal("Attribute uuid is mandatory for the action filter_by_uuid")
  end
  @client.fetch_nodes(["#{new_resource.uuid}"]).map do |node|
    node.instance_variables.each do |att|
      puts "#{att} - #{node.instance_variable_get att}"
    end
  end
end

action :power_on do
  create_client if @client.nil?
  if new_resource.uuid.nil?
    Chef::Log.fatal("Attribute uuid is mandatory when action is set to power_on")
  end
  @client.power_on_node(new_resource.uuid)
end

action :power_off do
  create_client if @client.nil?
  if new_resource.uuid.nil?
    Chef::Log.fatal("Attribute uuid is mandatory when action is set to power_off")
  end
  @client.power_off_node(new_resource.uuid)
end

action :power_restart do
  create_client if @client.nil?
  if new_resource.uuid.nil?
    Chef::Log.fatal("Attribute uuid is mandatory when action is set to power_restart")
  end
  @client.power_restart_node(new_resource.uuid)
end

action :blink_led do
  create_client if @client.nil?
  if new_resource.uuid.nil?
    Chef::Log.fatal("Attribute uuid is mandatory when action is set to blink_led")
  end
  @client.blink_loc_led(new_resource.uuid)
end

action :turn_on_led do
  create_client if @client.nil?
  if new_resource.uuid.nil?
    Chef::Log.fatal("Attribute uuid is mandatory when action is set to turn_on_led")
  end
  @client.turn_on_loc_led(new_resource.uuid)
end

action :turn_off_led do
  create_client if @client.nil?
  if new_resource.uuid.nil?
    Chef::Log.fatal("Attribute uuid is mandatory when action is set to turn_off_led")
  end
  @client.turn_off_loc_led(new_resource.uuid)
end

action :retrieve_mounted_media_details do
  create_client if @client.nil?
  if new_resource.uuid.nil?
    Chef::Log.fatal("Attribute uuid is mandatory")
  end
  res = @client.retrieve_mounted_media_details(new_resource.uuid) 
  if res.status == 200
    pp(res.body)
  else
    puts("")
    pp(res.status)
    pp(res.reason_phrase)
    pp(res.body)
  end
end

action :enable_media_mount_support_thinkserver do
  create_client if @client.nil?
  if new_resource.uuid.nil?
    Chef::Log.fatal("Attribute uuid is mandatory")
  end
  res = @client.enable_media_mount_support_thinkserver(new_resource.uuid)
  if res.status == 200
    pp(res.body)
  else
    puts("")
    pp(res.status)
    pp(res.reason_phrase)
    pp(res.body)
  end
end

action :disable_media_mount_support_thinkserver do
  create_client if @client.nil?
  if new_resource.uuid.nil?
    Chef::Log.fatal("Attribute uuid is mandatory")
  end
  res = @client.disable_media_mount_support_thinkserver(new_resource.uuid) 
  if res.status == 200
    pp(res.body)
  else
    puts("")
    pp(res.status)
    pp(res.reason_phrase)
    pp(res.body)
  end
end

action :remove_all_mounted_medias_thinksystem do
  create_client if @client.nil?
  if new_resource.uuid.nil?
    Chef::Log.fatal("Attribute uuid is mandatory")
  end
  res = @client.remove_all_mounted_medias_thinksystem(new_resource.uuid)
  if res.status == 200
    pp(res.body)
  else
    puts("")
    pp(res.status)
    pp(res.reason_phrase)
    pp(res.body)
  end
end

action :mount_media_thinkserver do
  create_client if @client.nil?
  if new_resource.uuid.nil?
    Chef::Log.fatal("Attribute uuid is mandatory")
  end
  res = @client.mount_media_thinkserver(new_resource.uuid, new_resource.opts)
  if res.status == 200
    sleep(10)
    pp(res.body)
  else
    puts("")
    pp(res.status)
    pp(res.reason_phrase)
    pp(res.body)
  end
end

action :mount_media_thinksystem do
  create_client if @client.nil?
  if new_resource.uuid.nil?
    Chef::Log.fatal("Attribute uuid is mandatory")
  end
  res = @client.mount_media_thinksystem(new_resource.uuid, new_resource.opts)
  if res.status == 200
    pp(res.body)
  else
    puts("")
    pp(res.status)
    pp(res.reason_phrase)
    pp(res.body)
  end
end

action :unmount_media_thinkserver do
  create_client if @client.nil?
  if new_resource.uuid.nil?
    Chef::Log.fatal("Attribute uuid is mandatory")
  end
  res = @client.unmount_media_thinkserver(new_resource.uuid,
                                          new_resource.media_type)
  if res.status == 200
    pp(res.body)
  else
    puts("")
    pp(res.status)
    pp(res.reason_phrase)
    pp(res.body)
  end
end

action :unmount_media_thinksystem do
  create_client if @client.nil?
  if new_resource.uuid.nil?
    Chef::Log.fatal("Attribute uuid is mandatory")
  end
  res = @client.unmount_media_thinksystem(new_resource.uuid,
                                          new_resource.media_uid)
  if res.status == 200
    pp(res.body)
  else
    puts("")
    pp(res.status)
    pp(res.reason_phrase)
    pp(res.body)
  end
end
