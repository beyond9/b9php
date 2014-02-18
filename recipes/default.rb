include_recipe "apache2"
include_recipe "apache2::mod_php5"

case node['platform_family']
when "rhel", "fedora", "suse"
  
  include_recipe "yum"

  include_recipe "b9php::remi"
  include_recipe "b9php::remi55"
  
  %w(
    php
    php-common
    php-cli
    php-gd
    php-ldap
    php-intl
    php-pear
    php-devel
    php-mbstring
    php-pdo
    php-mcrypt
    php-mysqlnd
    php-pecl-xdebug
    ant
    php-process
    php-opcache
    php-pecl-apcu
    php-soap
    php-memcached
  ).each do |p|
    yum_package p do
      action :install
      options("--enablerepo=remi --enablerepo=remi-php55")
    end
  end
end

directory "#{node[:php][:ext_conf_dir]}/httpd/" do
	action :create
end

template "#{node[:php][:ext_conf_dir]}/httpd/php.ini" do
  source "php.ini.erb"
  backup false
end

template "#{node['php']['conf_dir']}/php.ini" do
  source "php_cli.ini.erb"
  backup false
end

template "#{node[:apache][:dir]}/conf.d/php5.conf" do
  source "php5.conf.erb"
  backup false
end

template "#{node[:php][:ext_conf_dir]}/xdebug.ini" do
  source "xdebug.ini.erb"
end

template "#{node[:php][:ext_conf_dir]}/opcache.ini" do
  source "opcache.ini.erb"
end