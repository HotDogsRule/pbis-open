#
# Cookbook Name:: pbis-open
# Recipe:: install
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

# Download SFX from Beyond Trust

if platform?("ubuntu", "debian")
	sfxarch = node['kernel']['machine'] =~ /x86_64/ ? "x86_64" : "x86"
	urlarch = node['kernel']['machine'] =~ /x86_64/ ? "x64" : "i386"
	remote_file "#{Chef::Config[:file_cache_path]}/pbis-open-#{node['pbis-open']['version']}.linux.#{sfxarch}.deb.sh" do
		source "http://download.beyondtrust.com/PBISO/#{node['pbis-open']['version']}/linux.deb.#{urlarch}/pbis-open-#{node['pbis-open']['version']}.linux.#{sfxarch}.deb.sh"
		action :create_if_missing
	end
end

# Extract package

if platform?("ubuntu", "debian")
	execute "extract-pbis-open-sfx" do
		sfxarch = node['kernel']['machine'] =~ /x86_64/ ? "x86_64" : "x86"
		action :run
		cwd "#{Chef::Config[:file_cache_path]}"
		command "sh #{Chef::Config[:file_cache_path]}/pbis-open-#{node['pbis-open']['version']}.linux.#{sfxarch}.deb.sh --noexec"
		creates "#{Chef::Config[:file_cache_path]}/pbis-open-#{node['pbis-open']['version']}.linux.#{sfxarch}.deb/install.sh"
	end
end

# Define files

if platform?("ubuntu", "debian")
	debarch = node['kernel']['machine'] =~ /x86_64/ ? "amd64" : "i386"
	sfxarch = node['kernel']['machine'] =~ /x86_64/ ? "x86_64" : "x86"
	file "#{Chef::Config[:file_cache_path]}/pbis-open-#{node['pbis-open']['version']}.linux.#{sfxarch}.deb/packages/pbis-open-upgrade_#{node['pbis-open']['version']}_#{debarch}.deb" do
		action :create_if_missing
	end
	file "#{Chef::Config[:file_cache_path]}/pbis-open-#{node['pbis-open']['version']}.linux.#{sfxarch}.deb/packages/pbis-open_#{node['pbis-open']['version']}_#{debarch}.deb" do
		action :create_if_missing
	end
end

# Install packages

if platform?("ubuntu", "debian")
	debarch = node['kernel']['machine'] =~ /x86_64/ ? "amd64" : "i386"
	sfxarch = node['kernel']['machine'] =~ /x86_64/ ? "x86_64" : "x86"
	package "pbis-open-upgrade_#{node['pbis-open']['version']}_#{debarch}.deb" do
		source "#{Chef::Config[:file_cache_path]}/pbis-open-#{node['pbis-open']['version']}.linux.#{sfxarch}.deb/packages/pbis-open-upgrade_#{node['pbis-open']['version']}_#{debarch}.deb"
		provider Chef::Provider::Package::Dpkg
		action :install
	end
	package "pbis-open_#{node['pbis-open']['version']}_#{debarch}.deb" do
		source "#{Chef::Config[:file_cache_path]}/pbis-open-#{node['pbis-open']['version']}.linux.#{sfxarch}.deb/packages/pbis-open_#{node['pbis-open']['version']}_#{debarch}.deb"
		provider Chef::Provider::Package::Dpkg
		action :install
	end
end