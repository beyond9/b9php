include_recipe "yum-epel"

yum_repository 'remi' do
  description "Les RPM de remi pour Enterprise Linux #{node['platform_version']} - $basearch"
  mirrorlist node['yum']['remi']['url']
  gpgkey node['yum']['remi-php55']['key_url']
  enabled true
  action :create
end