name             'b9php'
maintainer       'Chris Escalante'
maintainer_email 'chris@beyond9.co'
license          'All rights reserved'
description      'Installs/Configures PHP 5.6 from Remi'
version          '0.0.2'

recipe "b9php", "Install php 5.6"
recipe "b9php::remi", "Installs REMI repo"
recipe "b9php::remi55", "Installs REMI55 repo"
recipe "b9php::remi56", "Installs REMI55 repo"
recipe "b9php::pear", "Installs pear extensions"
recipe "b9php::oracle", "Installs pear extensions"

depends "yum"
depends "apache2"
depends "php"
depends "yum-epel"