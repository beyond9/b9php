include_recipe "apache2"

case node['platform_family']
when "rhel", "fedora", "suse"
  
  include_recipe "yum"
  
  include_recipe "b9php::remi"
  include_recipe "b9php::remi55"
  
  %w(
    php-pecl-oci8
  ).each do |p|
    yum_package p do
      action :install
      options("--enablerepo=remi --enablerepo=remi-php55")
    end
  end
end

cookbook_file "/root/oracle-instantclient12.1-basic-12.1.0.1.0-1.x86_64.rpm" do
  source "oracle/oracle-instantclient12.1-basic-12.1.0.1.0-1.x86_64.rpm"
  mode "0644"
  owner "root"
  group "root"
end

cookbook_file "/root/oracle-instantclient12.1-devel-12.1.0.1.0-1.x86_64.rpm" do
  source "oracle/oracle-instantclient12.1-devel-12.1.0.1.0-1.x86_64.rpm"
  mode "0644"
  owner "root"
  group "root"
end

execute "install instant client" do
  command "rpm -Uvh /root/oracle-instantclient12.1-basic-12.1.0.1.0-1.x86_64.rpm > /dev/null 2>&1 &"
  action :run
  not_if "rpm -qa 2> /dev/null | grep 'oracle-instantclient12.1-basic-12.1.0.1.0-1.x86_64'"
end

execute "install instant client devel tools" do
  command "rpm -Uvh /root/oracle-instantclient12.1-devel-12.1.0.1.0-1.x86_64.rpm > /dev/null 2>&1 &"
  action :run
  not_if "rpm -qa 2> /dev/null | grep 'oracle-instantclient12.1-devel-12.1.0.1.0-1.x86_64'"
end

link "/usr/lib/oracle/12.1/client64/lib/libclntsh.so" do
  to "/usr/lib/oracle/12.1/client64/lib/libclntsh.so.12.1"
end

template "/etc/ld.so.conf.d/oracle12-client.conf" do
  source "oracle12-client.erb"
end

execute "initiailize ldconfig" do
  command "ldconfig 2> /dev/null"
  action :run
  notifies :restart, resources(:service => "apache2"), :delayed
end

template "#{node[:php][:ext_conf_dir]}/oci8.ini" do
  source "oci8.ini.erb"
  notifies :restart, resources(:service => "apache2"), :delayed
end