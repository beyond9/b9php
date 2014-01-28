include_recipe "yum-epel"

yum_repository 'remi-php55' do
  description "Les RPM de remi de PHP 5.5 pour Enterprise Linux #{node['platform_version']} - $basearch"
  mirrorlist node['yum']['remi-php55']['url']
  gpgkey node['yum']['remi-php55']['key_url']
  enabled true
  action :create
end