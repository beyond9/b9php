case node['platform']
when "fedora"
  default['yum']['remi-php55']['url'] = "http://rpms.famillecollet.com/fedora/#{node['platform_version'].to_i}/php55/mirror"
else
  default['yum']['remi-php55']['url'] = "http://rpms.famillecollet.com/enterprise/#{node['platform_version'].to_i}/php55/mirror"
end

default['yum']['remi-php55']['key'] = "RPM-GPG-KEY-remi"
default['yum']['remi-php55']['key_url'] = "http://rpms.famillecollet.com/#{node['yum']['remi-php55']['key']}"
default['yum']['remi-php55']['includepkgs'] = nil
default['yum']['remi-php55']['exclude'] = nil