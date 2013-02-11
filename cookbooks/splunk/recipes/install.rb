#   
# Cookbook Name:: splunk
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

log "Installing Splunk"

set_user "#{node[:splunk][:user]}"

directory node[:splunk][:installdir] do  
 owner "#{node[:splunk][:user]}"
 mode "0755"  
 action :create 
end 

remote_file "#{node[:splunk][:installdir]}/splunk.tar" do  
 source node[:splunk][:installfile]
 action :create_if_missing 
end 

bash "install_splunk" do
 cwd node[:splunk][:installdir]
 code <<-EOH
  tar -xvf splunk.tar
  EOH
end 

log "Updating Splunk Configuration"
bash "update_splunk_config" do
cwd node[:splunk][:installdir]
code <<-EOH
  cd splunk/etc/system/
  wget https://rsed-cheftraining.s3.amazonaws.com/splunk_update.tgz
  gzip -cd splunk_update.tgz |tar xvf -
 EOH
end 

template "#{node[:splunk][:installdir]}/splunk/bin/startsplunk" do
 source "startstopsplunk.erb"
 mode 0755
 action :create
 variables({
  :action => "start"
         })
end

template "#{node[:splunk][:installdir]}/splunk/bin/stopsplunk" do
 source "startstopsplunk.erb"
 mode 0755
 action :create
 variables({
  :action => "stop"
         })
end

template "#{node[:splunk][:installdir]}/splunk/bin/restartsplunk" do
 source "startstopsplunk.erb"
 mode 0755
 action :create
 variables({
   :action => "restart"
          })
end

package "tree"

log "The installation is complete" 
    
rightscale_marker :end

