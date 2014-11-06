include_recipe "apache2"
include_recipe "apache2::mod_php5"

case node['platform_family']
when "rhel", "fedora", "suse"
  
  include_recipe "yum"

  include_recipe "b9php::remi"
  include_recipe "b9php::remi56"
  
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
      options("--enablerepo=remi --enablerepo=remi-php56")
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

directory "#{node[:apache][:dir]}/conf.d" do
	action :create
end

template "#{node[:apache][:dir]}/conf.d/php5.conf" do
  source "php5.conf.erb"
  backup false
end
