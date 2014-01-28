cookbook_file "/usr/local/bin/pear-exitwrapper" do
  source "pear-exitwrapper.sh"
  mode "0755"
  owner "root"
  group "root"
end

execute "php-pear: auto discover for channels" do
  command "sudo /usr/local/bin/pear-exitwrapper config-set auto_discover 1"
end

channels = node[:php_pear][:channels]
channels.each do |channel|
  execute "php-pear: discover channel #{channel}" do
    ignore_failure true
    command "sudo /usr/local/bin/pear-exitwrapper channel-discover #{channel}"
    ignore_failure true
	end
end

execute "php-pear: update channel" do
  command "sudo /usr/local/bin/pear-exitwrapper channel-update pear.php.net"
end

packages = node[:php_pear][:packages]
packages.each do |package|
  execute "php-pear: install #{package}" do
    command "sudo /usr/local/bin/pear-exitwrapper install #{package}"
    ignore_failure true
	end
end