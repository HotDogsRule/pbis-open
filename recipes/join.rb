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

join_secret = Chef::EncryptedDataBagItem.load_secret("#{node['pbis-open']['encryption-key-path']}")
join = Chef::EncryptedDataBagItem.load('pbis-open', 'join', join_secret)
username = join['username']
password = join['password']

# Join domain

if platform?("ubuntu", "debian")
	execute "pbis-open-join-domain" do
		action :run
		command "/opt/pbis/bin/domainjoin-cli join #{node['pbis-open']['domain']} #{username} #{password}"
	end
end