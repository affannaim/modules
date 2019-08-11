class wordpress (
#sudo apt update
exec {'apt update':
 path => "/usr/bin",
 command => sudo apt update,
}

#sudo apt install -y apache2
package {"apache2":
 ensure => present,
}

#sudo service apache2 start
service {"apache2":
 ensure => start,
}

#sudo apt install -y mysql-server mysql-client
#sudo apt install -y php libapache2-mod-php php-mcrypt php-mysql
$pkg = ['mysql-server', 'mysql-client', 'php', 'libapache2-mod-php', 'php-mcrypt', 'php-mysql']
$pkg.each |string packg| {
package {"${packg}":
 ensure => present,
}

#mysqladmin -u root password rootpassword
exec {'mysqladmin':
 command => mysqladmin -u root password rootpassword,
}

#wget https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/mysqlcommands
#sudo cp mysqlcommands /tmp/mysqlcommands
exec {"wget https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/mysqlcommands":
 path => "/usr/bin",
 cwd =>"/tmp/mysqlcommands",
}

#mysql -uroot -prootpassword < /tmp/mysqlcommands
exec {'mysqlcommand':
 command => mysql -uroot -prootpassword < /tmp/mysqlcommands,
}

#wget https://wordpress.org/latest.zip
#cp latest.zip /tmp/latest.zip
exec {"wget https://wordpress.org/latest.zip":
 path => "/usr/bin",
 cwd =>"/tmp/latest.zip",
}

#sudo apt install -y unzip
package {"unzip":
 ensure => present,
}

#sudo unzip /tmp/latest.zip -d /var/www/html
exec {'unzip latest.zip':
 command => sudo unzip /tmp/latest.zip -d /var/www/html
}

#wget https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/wp-config-sample.php
#sudo cp wp-config-sample.php /var/www/html/wordpress/wp-config.php
exec {"wget https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/wp-config-sample.php":
 path => "/usr/bin",
 cwd =>"/var/www/html/wordpress/wp-config.php",
}

#sudo chmod -R 775 /var/www/html/wordpress
#sudo chown -R www-data:www-data /var/www/html/wordpress
file {'/var/www/html/wordpress':
 mode => '775'
 owner => 'www-data'
 group => 'www-data'
}

#sudo service apache2 restart
service {"apache2":
 ensure :restart,
}
)
