# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.







# Multi-VMs!
Vagrant.configure("2") do |config|
  #config.ssh.username = "admin"
  #config.ssh.password = "admin"
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.

  #Meine haupt VM. Diese VM hat alle Dienste installiert.
  config.vm.define "ural" do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "ural"
  config.vm.network "private_network", ip:"192.168.5.6"
  config.vm.network "forwarded_port", guest:80, host:8080, auto_correct: true
  config.vm.synced_folder ".", "/var/www/html"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"

 config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install firefox
    sudo apt-get install apache2 -y
    sudo apt-get install ufw -y
    sudo ufw allow from 10.0.2.2 to any port 22
    sudo ufw allow 80/tcp
    sudo ufw --force enable
    sudo apt-get install libapache2-mod-proxy-html -y
    sudo apt-get install libxml2-dev -y
    a2enmod proxy
    a2enmod proxy_html
    a2enmod proxy_http/41
    sed -i '$aServerName localhost' /etc/apache2/apache2.conf
    service apache2 restart
    cd /etc/apache2/sites-enabled
    wget https://pastebin.com/raw/GbjFC2ii
    cp GbjFC2ii 001-reverseproxy.conf


    #Gruppe Myadmin erstellen
    sudo groupadd myadmin
    #User erstellen
    sudo useradd admin -g myadmin -m -s /bin/bash
    sudo useradd test -g myadmin -m -s /bin/bash
    #Password festlegen
    sudo chpasswd <<<admin:admin
    sudo chpasswd <<<test:test
    #DHCP Server installieren
    sudo apt-get -y install isc-dhcp-server
    #DHCP Config-File konfigurieren
    #Domainanme konfigurieren
    sudo sed -i 's/example.org/labor.local/g' /etc/dhcp/dhcpd.conf
    #DNS konfigurieren
    sudo sed -i 's/ns2.labor.local/8.8.8.8/g' /etc/dhcp/dhcpd.conf
    #DHCP Autorisierung aktiviert
    sudo sed -i 's/#authoritative/authoritative/g' /etc/dhcp/dhcpd.conf
    #DHCP Subnetz & Maske konfigurieren
    sudo sed -i '$asubnet 192.168.6.0 netmask 255.255.255.0 {' /etc/dhcp/dhcpd.conf
    #DHCP Range konfigurieren
    sudo sed -i '$arange 192.168.6.100 192.168.6.130;' /etc/dhcp/dhcpd.conf
    #DHCP Gateway konfigurieren
    sudo sed -i '$aoption routers 192.168.6.1;' /etc/dhcp/dhcpd.conf
    sudo sed -i '$a}' /etc/dhcp/dhcpd.conf
    #DHCP Server neustarten
    sudo service isc-dhcp-server restart

    #Gruppe Myadmin erstellen
    sudo groupadd myadmin
    #User erstellen
    sudo useradd admin -g myadmin -m -s /bin/bash
    sudo useradd test -g myadmin -m -s /bin/bash
    #Password festlegen
    sudo chpasswd <<<admin:admin
    sudo chpasswd <<<test:test
    sudo apt-get -y install apache2
    sudo service apache2 restart

      #FTP Server installieren
  sudo apt-get -y install pure-ftpd-common pure-ftpd
  #FTP Server konfigurieren
  sudo groupadd ftpgroup
  sudo useradd -g ftpgroup -d /dev/null -s /etc ftpuser
  sudo pure-pw useradd ural -u ftpuser -g ftpgroup -d /home/pubftp/ural -N 10
  #FTP Server neustarten
  #sudo service pure-ftpd-common pure-ftpd restart
  sudo /home/pubftp/ural restart

    #Local Firewall installieren
    sudo apt-get -y install ufw gufw 
    sudo ufw allow from 10.0.2.2 to any port 22
    sudo ufw --force enable

    #Tastaturlayout anpassen
    sudo sed -i 's/XKBLAYOUT="us"/XKBLAYOUT="de"/g' /etc/default/locale



SHELL
end

#DHCP VM
config.vm.define "dhcp" do |dhcp|
  dhcp.vm.box = "ubuntu/trusty64"
  dhcp.vm.hostname = "dhcp"
  dhcp.vm.network "private_network", ip:"192.168.5.7" 
  dhcp.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"  

  dhcp.vm.provision "shell", inline: <<-SHELL
  #Gruppe Myadmin erstellen
  sudo groupadd myadmin
  #User erstellen
  sudo useradd admin -g myadmin -m -s /bin/bash
  sudo useradd test -g myadmin -m -s /bin/bash
  #Password festlegen
  sudo chpasswd <<<admin:admin
  sudo chpasswd <<<test:test
  #DHCP Server installieren
  sudo apt-get -y install isc-dhcp-server
  #DHCP Config-File konfigurieren
  #Domainanme konfigurieren
  sudo sed -i 's/example.org/labor.local/g' /etc/dhcp/dhcpd.conf
  #DNS konfigurieren
  sudo sed -i 's/ns2.labor.local/8.8.8.8/g' /etc/dhcp/dhcpd.conf
  #DHCP Autorisierung aktiviert
  sudo sed -i 's/#authoritative/authoritative/g' /etc/dhcp/dhcpd.conf
  #DHCP Subnetz & Maske konfigurieren
  sudo sed -i '$asubnet 192.168.6.0 netmask 255.255.255.0 {' /etc/dhcp/dhcpd.conf
  #DHCP Range konfigurieren
  sudo sed -i '$arange 192.168.6.100 192.168.6.130;' /etc/dhcp/dhcpd.conf
  #DHCP Gateway konfigurieren
  sudo sed -i '$aoption routers 192.168.6.1;' /etc/dhcp/dhcpd.conf
  sudo sed -i '$a}' /etc/dhcp/dhcpd.conf
  #DHCP Server neustarten
  sudo service isc-dhcp-server restart

  #Local Firewall installieren
  sudo apt-get -y install ufw gufw 
  sudo ufw allow from 10.0.2.2 to any port 22
  sudo ufw --force enable

  #Tastaturlayout anpassen
  sudo sed -i 's/XKBLAYOUT="us"/XKBLAYOUT="de"/g' /etc/default/locale
SHELL
end

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end

#FTP VM
#
config.vm.define "ftp" do |ftp|
  ftp.vm.box = "ubuntu/trusty64"
  ftp.vm.hostname = "ftp"
  ftp.vm.network "private_network", ip: "192.168.5.8"
  ftp.vm.network "forwarded_port", guest:3306, host:3306, auto_correct: true
  ftp.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"  

    ftp.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
  #FTP Server installieren
  sudo apt-get -y install pure-ftpd-common pure-ftpd
  #FTP Server konfigurieren
  sudo groupadd ftpgroup
  sudo useradd -g ftpgroup -d /dev/null -s /etc ftpuser
  sudo pure-pw useradd ural -u ftpuser -g ftpgroup -d /home/pubftp/ural -N 10
  #FTP Server neustarten
  #sudo service pure-ftpd-common pure-ftpd restart
  sudo /home/pubftp/ural restart
  SHELL
  end




#Apache VM
config.vm.define "apache" do |apache|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "apache"
  config.vm.network "private_network",ip:"192.168.5.9",netmask:"255.255.255.0",default_gateway:"192.168.6.1"
  config.vm.network "forwarded_port", guest:80, host:8080, auto_correct: true
  config.vm.synced_folder ".", "/var/www/html"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"

# Ab hier werden Services, die auf dem Server laufen sollen, und deren Einrichtung beschrieben
config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    #Gruppe Myadmin erstellen
    sudo groupadd myadmin
    #User erstellen
    sudo useradd admin -g myadmin -m -s /bin/bash
    sudo useradd test -g myadmin -m -s /bin/bash
    #Password festlegen
    sudo chpasswd <<<admin:admin
    sudo chpasswd <<<test:test
    sudo apt-get -y install apache2
    sudo service apache2 restart
    #Tastaturlayout anpassen
    sudo sed -i 's/XKBLAYOUT="us"/XKBLAYOUT="ch"/g' /etc/default/locale
    #Local Firewall installieren
    sudo apt-get -y install ufw gufw 
    sudo ufw allow from 10.0.2.2 to any port 22
    sudo ufw --force enable
SHELL
  end

    end
      end
    end
  end
 