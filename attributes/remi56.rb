case node['platform']
when "fedora"
  default['yum']['remi-php56']['url'] = "http://rpms.famillecollet.com/fedora/#{node['platform_version'].to_i}/php56/mirror"
else
  default['yum']['remi-php56']['url'] = "http://rpms.famillecollet.com/enterprise/#{node['platform_version'].to_i}/php56/mirror"
end


default['yum']['remi-php56']['key'] = "RPM-GPG-KEY-remi"
default['yum']['remi-php56']['key_url'] = "http://rpms.famillecollet.com/#{node['yum']['remi-php55']['key']}"
default['yum']['remi-php56']['includepkgs'] = nil
default['yum']['remi-php56']['exclude'] = nil