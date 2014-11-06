include_recipe "yum-epel"

yum_repository 'remi-php56' do
  description "Les RPM de remi de PHP 5.6 pour Enterprise Linux #{node['platform_version']} - $basearch"
  mirrorlist node['yum']['remi-php56']['url']
  gpgkey node['yum']['remi-php56']['key_url']
  enabled true
  action :create
end