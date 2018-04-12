#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2018, Tim Lee
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

cookbook_file '/etc/yum.conf' do
  source 'yum.conf'
  mode '0644'
end

package 'epel-release'

package 'nginx'

service 'nginx' do
  action [:enable, :start]
end

template '/usr/share/nginx/html/index.html' do
  source 'index.html.erb'
  mode '0644'
end

# package 'epel-release' do
#   action :install
# end

# package 'nginx' do
#   action :install
# end

directory '/etc/nginx' do
  owner 'root'
  group 'root'
  mode 0755
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  notifies :restart, 'service[nginx]', :immediately
end

directory '/etc/nginx/conf.d' do
  owner 'root'
  group 'root'
  mode 0755
  recursive true
end

template '/etc/nginx/conf.d/default.conf' do
  source 'default.conf.erb'
  notifies :restart, 'service[nginx]', :immediately
end
