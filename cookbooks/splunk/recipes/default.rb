#
# Cookbook Name:: splunk
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

log "Installing Splunk version 4"

user "splunk" do
 action :create
 shell "/bin/bash"
end


directory "/opt/cheftraining" do
 owner "splunk"
 mode "0755"
 action :create
end

remote_file "/opt/cheftraining/splunk.tar" do
 source "https://rsed-cheftraining.s3.amazonaws.com/splunk-4.3.4-136012-Linux-x86_64.tar"
 action :create_if_missing
end

bash "install_splunk" do
 cwd "/opt"
 code <<-EOH
  tar -xvf splunk.tar
  chown -R splunk /opt/cheftraining
  EOH
end

package "tree"
