#
# Cookbook Name:: pbis-open
# Recipe:: join
#
# Copyright 2013, Noah Mehl
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

join_secret = Chef::EncryptedDataBagItem.load_secret("#{node['pbis_open']['encryption_key_path']}")
join = Chef::EncryptedDataBagItem.load('pbis-open', 'join', join_secret)
username = join['username']
password = join['password']

# Join domain

execute "pbis_open_join_domain" do
	action :run
	command "/opt/pbis/bin/domainjoin-cli join #{node['pbis_open']['domain']} #{username} #{password}"
end

# Set some defaults

execute "assume_default_domain" do
	action :run
	command "/opt/pbis/bin/config AssumeDefaultDomain #{node['pbis_open']['default_domain']}"
end

execute "login_shell_template" do
	action :run
	command "/opt/pbis/bin/config LoginShellTemplate #{node['pbis_open']['login_shell_template']}"
end

execute "home_dir_template" do
	action :run
	command "/opt/pbis/bin/config HomeDirTemplate #{node['pbis_open']['home_dir_template']}"
end