# LB01

# K1

## Umgebung auf eigenem Notebook eingerichtet und funktionsfähig

Willkommen zu meiner Markdown über das Modul 300. Hier steht meine Vorgehensweise und meine Prozesse über die LBs im Modul.  Folgende Anleitungen / Links wurden für die Realisierung des LB01s gebraucht:

> https://github.com/uralerkut/M300 <-- my repo
>
> http://iotkit.mc-b.ch/tbz/M300V3/html/10-Installation/
>
> https://github.com/mc-b/M300/tree/master/vagrant/mmdb
>
> https://app.vagrantup.com/boxes/search
>
> https://github.com/mc-b/M300/tree/master/20-Infrastruktur#-02---infrastructure-as-code
>
> https://github.com/mc-b/M300/tree/master/10-Toolumgebung



### VirtualBox

VirtualBox wurde auf meiner Windows 10 Maschine (Surface Pro 4) installiert. Eine Ubuntu Server Maschine 18.04 wurde ebenfalls erfolgreich installiert.

Keine Probleme wurden bei der Installation von Synaptic entdeckt. Mein localhost ist erreichbar.





### Vagrant

> http://iotkit.mc-b.ch/tbz/M300V3/html/10-Installation/40-Vagrant.html

Vagrant konnte ich ebenfalls erfolgreich installieren lassen (mit dem Installer). Jedoch habe ich nach dem Neustarten meines PCs herausgefunden, dass mein PC Vagrant deinstalliert hat. Dies passierte zwei-Mal.

Bei der Anleitung von der Vagrant-Installation, stolperte ich am stärksten. Mein Computer erkennt Virtualbox nicht, obwohl die virtualbox-dkms und die headers schon installiert waren. Folgenden Befehl versuchte ich sämtliche Male auszuführen:

```bash
mkdir MeineVagrantVM
cd MeineVagrantVM
vagrant init ubuntu/xenial64
vagrant up --provider virtualbox <- error
```

Dann habe ich gemerkt, dass ich etwas vergessen habe...

```bash
vagrant box add http://10.1.66.11/vagrant/ubuntu/xenial64.box --name ubuntu/xenial64


```

Folgende Fehlermeldung habe ich erhalten

```bash
root@ROXAS:/mnt/c/Users/urale/Documents/MeineVagrantVM# vagrant box add http://10.1.66.11/vagrant/ubuntu/xenial64.box --name ubuntu/xenial64
/usr/bin/vagrant:57: warning: Insecure world writable dir /mnt/c/Program Files (x86)/Common Files/Intel/Shared Libraries/redist/intel64/compiler in PATH, mode 040777
/usr/lib/ruby/vendor_ruby/vagrant/pre-rubygems.rb:33: warning: Insecure world writable dir /mnt/c/Program Files (x86)/Common Files/Intel/Shared Libraries/redist/intel64/compiler in PATH, mode 040777
/usr/lib/ruby/vendor_ruby/bundler/shared_helpers.rb:78: warning: Insecure world writable dir /mnt/c/Program Files (x86)/Common Files/Intel/Shared Libraries/redist/intel64/compiler in PATH, mode 040777
==> box: Box file was not detected as metadata. Adding it directly...
==> box: Adding box 'ubuntu/xenial64' (v0) for provider:
    box: Downloading: http://10.1.66.11/vagrant/ubuntu/xenial64.box
An error occurred while downloading the remote file. The error
message, if any, is reproduced below. Please fix this error and try
again.

Failed to connect to 10.1.66.11 port 80: Connection refused

root@ROXAS:/mnt/c/Users/urale/Documents/MeineVagrantVM# vagrant up --provider virtualbox
/usr/bin/vagrant:57: warning: Insecure world writable dir /mnt/c/Program Files (x86)/Common Files/Intel/Shared Libraries/redist/intel64/compiler in PATH, mode 040777
/usr/lib/ruby/vendor_ruby/vagrant/pre-rubygems.rb:33: warning: Insecure world writable dir /mnt/c/Program Files (x86)/Common Files/Intel/Shared Libraries/redist/intel64/compiler in PATH, mode 040777
/usr/lib/ruby/vendor_ruby/bundler/shared_helpers.rb:78: warning: Insecure world writable dir /mnt/c/Program Files (x86)/Common Files/Intel/Shared Libraries/redist/intel64/compiler in PATH, mode 040777
The provider 'virtualbox' that was requested to back the machine
'default' is reporting that it isn't usable on this system. The
reason is shown below:

VirtualBox is complaining that the installation is incomplete. Please
run `VBoxManage --version` to see the error message which should contain
instructions on how to fix this error.
root@ROXAS:/mnt/c/Users/urale/Documents/MeineVagrantVM# vboxmanage --version
WARNING: The character device /dev/vboxdrv does not exist.
         Please install the virtualbox-dkms package and the appropriate headers, most likely linux-headers-Microsoft.
You will not be able to start VMs until this problem is fixed.
5.1.38_Ubuntur122592

You will not be able to start VMs until this problem is fixed.
```

Googeln half mir nicht wirklich weiter. Auf einem reddit/ubuntu Forum, konnte ich eine Lösung finden. Leider war diese Lösung nicht erfolgreich für mich.

```bash
apt-get install linux-headers-`uname -r`
dpkg-reconfigure virtualbox-{numbers}
```

> 'uname -r ersetzt mit der Nummer z.B 4.4.0' (diese Installation kostete mir viel Geduld und 48 Stunden Installationszeit)

Ebenfalls habe ich versucht Virtualbox, dessen dkms, und Vagrant nochmal zu installieren. Leider ohne Erfolg.

> ```bash
> sudo apt-get remove virtualbox-dkms  
> sudo apt-get install virtualbox-dkms 
> ```

Auch

```bash
sudo dpkg-reconfigure virtualbox-dkms
sudo dpkg-reconfigure virtualbox
sudo modprobe vboxdrv
```

Ich bekomme ständig komplexe FATAL Error-Meldungen. Das Internet hilft leider nicht, jedoch kann ich lesen, dass etwas mit den Intel libs nicht stimmt. Keine Komptabilität mit meinem CPU vielleicht?

Auf jeden Fall bekomme ich eine VM, Mithilfe von Vagrant, nicht zum laufen.

EDIT: Neulich (stand 20 März 2019), konnte ich Vagrant endlich(!) zum laufen bringen. Ich habe sämtliche ähnliche Linux-Headers installiert (welche mir in Total etwa 30GB Speicherplatz raubten...) und die Befehle mit "git bash" ausführen lassen.

Laut Anleitung von Herrn Kaelin, muss man das Verzeichnis vom Vagrant Cloud hinzufügen. Die IP-Adresse ist aber veraltet und funktioniert nicht (Port 80 timeout).

```bash
$ vagrant box add http://10.1.66.11/vagrant/ubuntu/xenial64.box --name ubuntu/xenial64  #Vagrant-Box vom Netzwerkshare hinzufügen, falls nicht vorhanden
  $ vagrant init ubuntu/xenial64                                                      #Vagrantfile erzeugen
  $ vagrant up --provider virtualbox  
```

```bash
urale@ROXAS MINGW64 ~/vagrant/MeineVagrantVM
$ vagrant box add http://10.1.66.11/vagrant/ubuntu/xenial64.box --name ubuntu/xenial64
==> box: Box file was not detected as metadata. Adding it directly...
==> box: Adding box 'ubuntu/xenial64' (v0) for provider:
    box: Downloading: http://10.1.66.11/vagrant/ubuntu/xenial64.box
    box:
An error occurred while downloading the remote file. The error
message, if any, is reproduced below. Please fix this error and try
again.

Failed to connect to 10.1.66.11 port 80: Timed out

```

Aus diesem Grund, habe ich mich kurzfristig entschieden, eine andere "Box" zu fischen, nämlich die von trusty64, anstatt von xenial64.

```bash
urale@ROXAS MINGW64 ~/vagrant/MeineVagrantVM
$ vagrant init ubuntu/trusty64
A `Vagrantfile` has been placed in this directory. You are now
ready to `vagrant up` your first virtual environment! Please read
the comments in the Vagrantfile as well as documentation on
`vagrantup.com` for more information on using Vagrant.

urale@ROXAS MINGW64 ~/vagrant/MeineVagrantVM
$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Box 'ubuntu/trusty64' could not be found. Attempting to find and install...
    default: Box Provider: virtualbox
    default: Box Version: >= 0
==> default: Loading metadata for box 'ubuntu/trusty64'
    default: URL: https://vagrantcloud.com/ubuntu/trusty64
==> default: Adding box 'ubuntu/trusty64' (v20190315.0.0) for provider: virtualbox
    default: Downloading: https://vagrantcloud.com/ubuntu/boxes/trusty64/versions/20190315.0.0/providers/virtualbox.box
    default: Download redirected to host: cloud-images.ubuntu.com
    default:
==> default: Successfully added box 'ubuntu/trusty64' (v20190315.0.0) for 'virtualbox'!
==> default: Importing base box 'ubuntu/trusty64'...
==> default: Matching MAC address for NAT networking...
==> default: Checking if box 'ubuntu/trusty64' version '20190315.0.0' is up to date...
==> default: Setting the name of the VM: MeineVagrantVM_default_1553092956111_62710
==> default: Clearing any previously set forwarded ports...
Vagrant is currently configured to create VirtualBox synced folders with
the `SharedFoldersEnableSymlinksCreate` option enabled. If the Vagrant
guest is not trusted, you may want to disable this option. For more
information on this option, please refer to the VirtualBox manual:

  https://www.virtualbox.org/manual/ch04.html#sharedfolders

This option can be disabled globally with an environment variable:

  VAGRANT_DISABLE_VBOXSYMLINKCREATE=1

or on a per folder basis within the Vagrantfile:

  config.vm.synced_folder '/host/path', '/guest/path', SharedFoldersEnableSymlinksCreate: false
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: private key
    default: Warning: Connection aborted. Retrying...
    default: Warning: Connection reset. Retrying...
    default:
    default: Vagrant insecure key detected. Vagrant will automatically replace
    default: this with a newly generated keypair for better security.
    default:
    default: Inserting generated public key within guest...
    default: Removing insecure key from the guest if it's present...
    default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
    default: The guest additions on this VM do not match the installed version of
    default: VirtualBox! In most cases this is fine, but in rare cases it can
    default: prevent things such as shared folders from working properly. If you see
    default: shared folder errors, please make sure the guest additions within the
    default: virtual machine match the version of VirtualBox you have installed on
    default: your host and reload your VM.
    default:
    default: Guest Additions Version: 4.3.36
    default: VirtualBox Version: 6.0
==> default: Mounting shared folders...
    default: /vagrant => C:/Users/urale/vagrant/MeineVagrantVM

urale@ROXAS MINGW64 ~/vagrant/MeineVagrantVM

```

Meine Laune wurde nach der erfolgreichen Installation und Downloads positiv.

```bash
urale@ROXAS MINGW64 ~/vagrant/MeineVagrantVM
$ vagrant ssh
Welcome to Ubuntu 14.04.6 LTS (GNU/Linux 3.13.0-167-generic x86_64)

 * Documentation:  https://help.ubuntu.com/

 System information disabled due to load higher than 1.0

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

0 packages can be updated.
0 updates are security updates.

New release '16.04.6 LTS' available.
Run 'do-release-upgrade' to upgrade to it.

```



### Visualstudio-Code

Da ich dieses Programm schon auf meinem Computer installiert habe, war keine zusätzliche Installation nötig. Jedoch habe ich die zwei Extensions dazu installiert.

> Vagrant Extension von Marco Stanzi
>
> vscode-pdf Extension von tomiko1207

### Git-Client

Der Git-Client wurde erfolgreich auf meinem Computer installiert. Ein repo wurde von meinem Github Account erfolgreich geklont.

> https://github.com/uralerkut/M300



### SSH-Key für Client erstellt

Terminal (*Bash*) öffnen

Folgenden Befehl mit der Account-E-Mail von GitHub einfügen:

```bash
  $  ssh-keygen -t rsa -b 4096 -C "ural.erkut1@gmail.com"
```

Neuer SSH-Key wird erstellt:

```bash
  Generating public/private rsa key pair.
```

Bei der Abfrage, unter welchem Namen der Schlüssel gespeichert werden soll, die Enter-Taste drücken (für Standard):

```bash
  Enter a file in which to save the key (~/.ssh/id_rsa): [Press enter]
```

Nun kann ein Passwort für den Key festgelegt werden. Ich empfehle dieses zu setzen und anschliessend dem SSH-Agent zu hinterlegen, sodass keine erneute Eingabe (z.B. beim Pushen) notwendig ist:

```bash
  Enter passphrase (empty for no passphrase): [Passwort]
  Enter same passphrase again: [Passwort wiederholen]
```

```bash
root@ROXAS:~/ubuntu# ssh-keygen -t rsa -b 4096 -C "ural.erkut1@gmail.com"
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /root/.ssh/id_rsa.
Your public key has been saved in /root/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:Cw5sJ1bDYJDJOPYnDxuLQE7sPLaSKPIaRdF7JsX2hno ural.erkut1@gmail.com
The key's randomart image is:
+---[RSA 4096]----+
|.oo=o.           |
|o=+o.o+          |
|B.o  ++o         |
|.B *oo+.o        |
|+.= #=o.S        |
|*+ =.*E. .       |
|=.   .. .        |
| ..              |
|..               |
+----[SHA256]-----+
root@ROXAS:~/ubuntu#
```

#### SSH-Key dem SSH-Agent hinzufügen

**Windows und Linux**

Datei %HOME%/.ssh/id_rsa.pub oder $HOME/.ssh/id_rsa.pub in Zwischenablage kopieren.

**macOS**

Terminal (*Bash*) öffnen

SSH-Agent starten:

```
  $ eval "$(ssh-agent -s)"
  Agent pid 931
```

Ab Version macOS High Sierra 10.12.2 muss das

 

```
~/.ssh/config
```

 

File angepasst werden, damit SSH-Keys automatisch dem SSH-Agent hinzugefügt werden:

```
  $ sudo nano ~/.ssh/config
  
  Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa
```

Nun muss der Schlüssel dem Agent nur noch hinzugefügt werden:

```
  $ ssh-add -K ~/.ssh/id_rsa
```

Der SSH-Key muss nun nur noch kopiert und anschliessend dem GitHub-Account hinzugefügt werden (siehe "SSH-Key hinzufügen"):

```
  $ pbcopy < ~/.ssh/id_rsa.pub
  # Kopiert den Inhalt der id_rsa.pub Datei in die Zwischenablage
```

### SSH-Key hinzufügen (Github)

------

Anmelden unter [www.github.com](http://www.github.com/)

Auf Benutzerkonto klicken (oben rechts) und den Punkt **Settings** aufrufen

Unter den Menübereichen auf der linken Seite zum Abschnitt **SSH und GPG keys** wechseln

Auf **New SSH key** klicken

Im Formular unter **Title** eine Bezeichnung vergeben (z.B. MB SSH-Key)

Den zuvor kopierten Key mit *CTRL + V* einfügen und auf **Add SSH key** klicken

Der Schlüssel (SSH-Key) sollte nun in der übergeordneten Liste auftauchen

```bash
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCsybLPmHh/P+I1yhzvK+JvqT1Q6ZZyuscPVmoe8fLWwvSKI5jwZ6MttWfitqkfCqmnVw87KDY3p9vuUhu5V8IFBIYmfRASom65jMkq18TpYLtqG9IwsN9aqfCWVk73d0WQdJAVaU6PQUcl0NZUd8jBqVHZb0AOfPaEmER0Jnyz+D4Wy5LtszojjsW8oFnpx60ZI9d/h9FF+TxNuhTPuHm67Cn31IdNIRIVPlESo2WdKlAshwnLW0v/c1pxkDIjHWcKsEuYc4kQGfynCmkQH+UTU2ZMp/xhShX0vJqgjjmxy9PyRxmyNkpHuNd4EupjSWhD6JbgpctU/1ep+JSHykhc7sq9RVVNEvJAvu/l2AgblxI2lXd5xXpEGlffZJZCVnOlHbIyD6r9WZTKW7uNYffXmj1V9nT8RCmhWWmFbSnAmgaPZiot7XLD09cpLU0d9YwkDWKQ4rc5exa47ts3N10PKYXs0h21l0geUDTjgtmZE7KZ73KJCm+w5cVJYeKGTpcZVVH6G5/mS2sYgdcufumEMHNwZUc1w4Sw4BSce8YGcZEFvBxrwojdVPEZRHZUiFA0VlAeucxotR+1U3CTL9lqhRVLEQXuFmrrwtWpUPW3nBuGcBBJGLtkGPUCahlpDMX75vN2ok+MtEUCnYoeuD1gIHTxy/PfNYsbYwLpNbuu6Q== ural.erkut1@gmail.com
```

![1552595015951](C:\Users\urale\AppData\Roaming\Typora\typora-user-images\1552595015951.png)

<a href="https://imgur.com/s8CJJdJ"><img src="https://i.imgur.com/s8CJJdJ.png" title="source: imgur.com" /></a>





> Weiter Infos zu SSH-Keys in Zusammenhang mit GitHub und dem SSH-Agent findet man unter:

> **GitHub-Help:** <https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/>

> **Wikipedia:** <https://en.wikipedia.org/wiki/Ssh-agent>

# K2

## Eigene Lernumgebung (PLE) ist eingerichtet



### GitHub oder Gitlab-Account ist erstellt

Ein GitHub-Account konnte ich problemlos erstellen.



### Git-Client wurde verwendet

Mein Git-Client ist aktiv und mein repo wurde auch geklont.

![Capture](C:\Users\urale\OneDrive - TBZ\Dokumente Modul 300\Capture.PNG)

<a href="https://imgur.com/dFzVv9T"><img src="https://i.imgur.com/dFzVv9T.png" title="source: imgur.com" /></a>



### Dokumentation ist als Markdown vorhanden, Editor ausgewählt und eingerichtet, strukturiert

Mein .md wurde mit Typora geschrieben, eingerichtet und strukturiert.



### Persönlicher Wissenstand im Bezug auf die wichtigsten Themen sind dokumentiert (Linux, VM, Vagrant, Git, .md, Sicherheit)

- Linux: 

  Da ich Ubuntu Server 18.04 für die LB01 verwende, heisst das auch, dass ich Erfahrungen in Ubuntu (oder generell Linux) habe.

- VM: 

  Zuhause verwende ich die VMware Workstation (betrieben mit Kali Linux). Bezüglich VMs, habe ich genügend Erfahrung für die Realisierung der Lernbeurteilungen dieses Modules.

- Vagrant: 

  Vagrant kannte ich vorher nicht. Hier sind die wichtigsten Befehle (für den bash Terminal) aufgelistet:

```bash
$ vagrant ssh. #SSH into virtual machine.
$ vagrant up. #Start virtual machine.
$ vagrant share. #Share your virtual machine to the world via a temporary and unique url.
$ vagrant halt. #Halt virtual machine.
$ vagrant destroy. #Destroy your virtual machine. ...
$ vagrant provision. #Reconfigure the virtual machine after a source code change.
$ vagrant reload. #Reload the virtual machine. Useful when you need to change network or synced folder settings.

#Genauere und mehrere Infos, findet man unter der offizielen Dokumentation: https://www.vagrantup.com/docs/cli/
```

- Git, .md, Sicherheit: 

  Da habe ich bei den vorherigen Modulen schon Erfahrungen sammeln können und kann diese ebenfalls für dieses Modul ausnutzen.



# K3

## Vagrant (Kriterien)

### Bestehende VM aus Vagrant-Cloud einrichten

Wie unter K1 "Vagrant" beschrieben, habe ich die trusty64 Box genommen und kreiert.

```bash
urale@ROXAS MINGW64 ~/vagrant/MeineVagrantVM
$ vagrant init ubuntu/trusty64
A `Vagrantfile` has been placed in this directory. You are now
ready to `vagrant up` your first virtual environment! Please read
the comments in the Vagrantfile as well as documentation on
`vagrantup.com` for more information on using Vagrant.

urale@ROXAS MINGW64 ~/vagrant/MeineVagrantVM
$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Box 'ubuntu/trusty64' could not be found. Attempting to find and install...
    default: Box Provider: virtualbox
    default: Box Version: >= 0
==> default: Loading metadata for box 'ubuntu/trusty64'
    default: URL: https://vagrantcloud.com/ubuntu/trusty64
==> default: Adding box 'ubuntu/trusty64' (v20190315.0.0) for provider: virtualbox
    default: Downloading: https://vagrantcloud.com/ubuntu/boxes/trusty64/versions/20190315.0.0/providers/virtualbox.box
    default: Download redirected to host: cloud-images.ubuntu.com
    default:
==> default: Successfully added box 'ubuntu/trusty64' (v20190315.0.0) for 'virtualbox'!
==> default: Importing base box 'ubuntu/trusty64'...
==> default: Matching MAC address for NAT networking...
==> default: Checking if box 'ubuntu/trusty64' version '20190315.0.0' is up to date...
==> default: Setting the name of the VM: MeineVagrantVM_default_1553092956111_62710
==> default: Clearing any previously set forwarded ports...
Vagrant is currently configured to create VirtualBox synced folders with
the `SharedFoldersEnableSymlinksCreate` option enabled. If the Vagrant
guest is not trusted, you may want to disable this option. For more
information on this option, please refer to the VirtualBox manual:

  https://www.virtualbox.org/manual/ch04.html#sharedfolders

This option can be disabled globally with an environment variable:

  VAGRANT_DISABLE_VBOXSYMLINKCREATE=1

or on a per folder basis within the Vagrantfile:

  config.vm.synced_folder '/host/path', '/guest/path', SharedFoldersEnableSymlinksCreate: false
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: private key
    default: Warning: Connection aborted. Retrying...
    default: Warning: Connection reset. Retrying...
    default:
    default: Vagrant insecure key detected. Vagrant will automatically replace
    default: this with a newly generated keypair for better security.
    default:
    default: Inserting generated public key within guest...
    default: Removing insecure key from the guest if it's present...
    default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
    default: The guest additions on this VM do not match the installed version of
    default: VirtualBox! In most cases this is fine, but in rare cases it can
    default: prevent things such as shared folders from working properly. If you see
    default: shared folder errors, please make sure the guest additions within the
    default: virtual machine match the version of VirtualBox you have installed on
    default: your host and reload your VM.
    default:
    default: Guest Additions Version: 4.3.36
    default: VirtualBox Version: 6.0
==> default: Mounting shared folders...
    default: /vagrant => C:/Users/urale/vagrant/MeineVagrantVM

urale@ROXAS MINGW64 ~/vagrant/MeineVagrantVM
```

Zusätzlich habe ich ubuntu-desktop installieren lassen

```bash
urale@ROXAS MINGW64 ~/vagrant/MeineVagrantVM
$ vagrant ssh
Welcome to Ubuntu 14.04.6 LTS (GNU/Linux 3.13.0-167-generic x86_64)

 * Documentation:  https://help.ubuntu.com/

 System information disabled due to load higher than 1.0

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

0 packages can be updated.
0 updates are security updates.

New release '16.04.6 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


vagrant@vagrant-ubuntu-trusty-64:~$ sudo apt-get update
Ign http://archive.ubuntu.com trusty InRelease
Get:1 http://archive.ubuntu.com trusty-updates InRelease [65.9 kB]
Hit http://archive.ubuntu.com trusty-backports InRelease
Hit http://archive.ubuntu.com trusty Release.gpg
Get:2 http://archive.ubuntu.com trusty-updates/main Sources [429 kB]
Get:3 http://archive.ubuntu.com trusty-updates/restricted Sources [6,313 B]
Get:4 http://archive.ubuntu.com trusty-updates/universe Sources [231 kB]
Get:5 http://archive.ubuntu.com trusty-updates/multiverse Sources [7,438 B]
Get:6 http://archive.ubuntu.com trusty-updates/main amd64 Packages [1,155 kB]
Get:7 http://archive.ubuntu.com trusty-updates/restricted amd64 Packages [17.2 kB]
Get:8 http://archive.ubuntu.com trusty-updates/universe amd64 Packages [518 kB]
Get:9 http://archive.ubuntu.com trusty-updates/multiverse amd64 Packages [14.6 kB]
Get:10 http://archive.ubuntu.com trusty-updates/main Translation-en [573 kB]
Get:11 http://archive.ubuntu.com trusty-updates/multiverse Translation-en [7,616 B]
Get:12 http://archive.ubuntu.com trusty-updates/restricted Translation-en [4,028 B]
Get:13 http://archive.ubuntu.com trusty-updates/universe Translation-en [278 kB]
Get:14 http://security.ubuntu.com trusty-security InRelease [65.9 kB]
Get:15 http://security.ubuntu.com trusty-security/main Sources [171 kB]
Get:16 http://archive.ubuntu.com trusty-backports/main Sources [9,709 B]
Get:17 http://archive.ubuntu.com trusty-backports/restricted Sources [28 B]
Get:18 http://archive.ubuntu.com trusty-backports/universe Sources [35.4 kB]
Get:19 http://archive.ubuntu.com trusty-backports/multiverse Sources [1,896 B]
Hit http://archive.ubuntu.com trusty-backports/main amd64 Packages
Hit http://archive.ubuntu.com trusty-backports/restricted amd64 Packages
Hit http://archive.ubuntu.com trusty-backports/universe amd64 Packages
Hit http://archive.ubuntu.com trusty-backports/multiverse amd64 Packages
Hit http://archive.ubuntu.com trusty-backports/main Translation-en
Hit http://archive.ubuntu.com trusty-backports/multiverse Translation-en
Hit http://archive.ubuntu.com trusty-backports/restricted Translation-en
Get:20 http://security.ubuntu.com trusty-security/universe Sources [101 kB]
Hit http://archive.ubuntu.com trusty-backports/universe Translation-en
Hit http://archive.ubuntu.com trusty Release
Get:21 http://archive.ubuntu.com trusty/main Sources [1,064 kB]
Get:22 http://security.ubuntu.com trusty-security/main amd64 Packages [822 kB]
Get:23 http://archive.ubuntu.com trusty/restricted Sources [5,433 B]
Get:24 http://archive.ubuntu.com trusty/universe Sources [6,399 kB]
Get:25 http://security.ubuntu.com trusty-security/universe amd64 Packages [288 kB]
Get:26 http://security.ubuntu.com trusty-security/main Translation-en [440 kB]
Get:27 http://security.ubuntu.com trusty-security/universe Translation-en [156 kB]
Get:28 http://archive.ubuntu.com trusty/multiverse Sources [174 kB]
Hit http://archive.ubuntu.com trusty/main amd64 Packages
Hit http://archive.ubuntu.com trusty/restricted amd64 Packages
Hit http://archive.ubuntu.com trusty/universe amd64 Packages
Hit http://archive.ubuntu.com trusty/multiverse amd64 Packages
Hit http://archive.ubuntu.com trusty/main Translation-en
Hit http://archive.ubuntu.com trusty/multiverse Translation-en
Hit http://archive.ubuntu.com trusty/restricted Translation-en
Hit http://archive.ubuntu.com trusty/universe Translation-en
Ign http://archive.ubuntu.com trusty/main Translation-en_US
Ign http://archive.ubuntu.com trusty/multiverse Translation-en_US
Ign http://archive.ubuntu.com trusty/restricted Translation-en_US
Ign http://archive.ubuntu.com trusty/universe Translation-en_US
Fetched 13.0 MB in 13s (978 kB/s)
Reading package lists... Done
vagrant@vagrant-ubuntu-trusty-64:~$ whoami
vagrant
vagrant@vagrant-ubuntu-trusty-64:~$ sudo -i
root@vagrant-ubuntu-trusty-64:~# passwd
Enter new UNIX password:
Retype new UNIX password:
passwd: password updated successfully
root@vagrant-ubuntu-trusty-64:~# sudo apt-get install ubuntu-desktop

```

![1553109943068](C:\Users\urale\AppData\Roaming\Typora\typora-user-images\1553109943068.png)

[I<a href="https://imgur.com/NViQnpj"><img src="https://i.imgur.com/NViQnpj.png" title="source: imgur.com" /></a>

### Kennt die Vagrant-Befehle

Die Basics kenne ich, jedoch habe ich ein "cheat sheet" in .md und werfe ab und zu meine Blicke dort drauf.

Diese .md-Datei habe ich ebenfalls in meinem repo hochgeladen.



### Eingerichtete Umgebung ist dokumentiert 

Siehe diese .md-Datei.



# K4

## Sicherheitsaspekte sind implementiert

### Firewall eingerichtet inkl. Rules

In meinem Vagrantfile sieht man, dass eine Ubuntu VM mit einer Firewall Reproxy installiert wird. Die Ports habe ich so abgeändert, dass jegliche Kommunikation von der IP 10.0.2.2 zugelassen wird. Ebenfalls wird TCP durch den Port 80 zugelassen.

Aus skeptischen Gründen, habe ich zusätzlich den Force Command eingebaut (um sicherzugehen...)

```bash
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip:"192.168.137.203"
  config.vm.network "forwarded_port", guest:80, host:8080, auto_correct: true
  config.vm.synced_folder ".", "/var/www/html"
 config.vm.provider "virtualbox" do |vb|
  vb.memory = "512"
 end
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
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
  SHELL
end
```

Eine Verbindung zur VM funktioniert einwandfrei

```bash
urale@ROXAS MINGW64 ~/vagrant/MeineVagrantVM
$ vagrant ssh
Welcome to Ubuntu 14.04.6 LTS (GNU/Linux 3.13.0-167-generic x86_64)

 * Documentation:  https://help.ubuntu.com/

  System information as of Wed Mar 20 19:58:29 UTC 2019

  System load:  0.78              Processes:           83
  Usage of /:   3.6% of 39.34GB   Users logged in:     0
  Memory usage: 13%               IP address for eth0: 10.0.2.15
  Swap usage:   0%

  Graph this data and manage this system at:
    https://landscape.canonical.com/

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

0 packages can be updated.
0 updates are security updates.

New release '16.04.6 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


vagrant@vagrant-ubuntu-trusty-64:~$

```

Die Firewall ist aktiv

```bash
vagrant@vagrant-ubuntu-trusty-64:~$ sudo -i
root@vagrant-ubuntu-trusty-64:~# ufw enable
Command may disrupt existing ssh connections. Proceed with operation (y|n)? y
Firewall is active and enabled on system startup
root@vagrant-ubuntu-trusty-64:~#

```

### Benutzervergabe ist eingerichtet + DHCP Server

```bash
dhcp.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
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
    sudo service isc-dhcpd-server restart
    #Tastaturlayout anpassen
    sudo sed -i 's/XKBLAYOUT="us"/XKBLAYOUT="de"/g' /etc/default/locale
```

DHCP Dienst testen mit

```bash
vagrant@dhcp:~$ sudo service isc-dhcp-server status

```



### SSH-Tunnel wurde abgesichtert (pw auth.)

Kontrollieren ob PasswordAuthentication auf yes ist in...

```bash
root@dhcp:~# cd /etc/ssh
root@dhcp:/etc/ssh# sudo nano sshd_config
root@dhcp:/etc/ssh#

```

Dann einloggen mit dem user "test" (pw = test)

```bash
urale@ROXAS MINGW64 ~/vagrant/MeineVagrantVM
$ ssh -p 2222 test@localhost
The authenticity of host '[localhost]:2222 ([127.0.0.1]:2222)' can't be established.
ECDSA key fingerprint is SHA256:pC4OaTFv3sujVJEcr/sJIPRJ0B2X6JRLa0YMYItofS8.
Are you sure you want to continue connecting (yes/no)? y
Please type 'yes' or 'no': yes
Warning: Permanently added '[localhost]:2222' (ECDSA) to the list of known hosts.
test@localhost's password:
Welcome to Ubuntu 14.04.6 LTS (GNU/Linux 3.13.0-167-generic x86_64)

 * Documentation:  https://help.ubuntu.com/

  System information as of Wed Mar 20 20:49:57 UTC 2019

  System load:  0.29              Processes:           81
  Usage of /:   3.7% of 39.34GB   Users logged in:     0
  Memory usage: 15%               IP address for eth0: 10.0.2.15
  Swap usage:   0%                IP address for eth1: 192.168.5.6

  Graph this data and manage this system at:
    https://landscape.canonical.com/

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

New release '16.04.6 LTS' available.
Run 'do-release-upgrade' to upgrade to it.



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

test@dhcp:~$

```



# K5

## Zusätzliche Bewertungspunkte

### Reflexion

Ich fand die LB01 äusserst spannend. Da "clouding" gerade aktuell in der Welt der Informatiker ist, ist das Modul 300 ein guter Einstieg in das Thema.

Persönlich hatte ich viele Steine im Wege und ich konnte sie nicht alle wegräumen, da mir die Zeit fehlte.

Zuerst verlor ich enorm viel Zeit bei der Installation von Vagrant. Das zu fixen, raubte mir etwa vier Donnerstage und zwei ganze Wochenenden. Schlussendlich konnte ich am 20. März das Problem lösen.

Da die Abgabe am 21. März erfolgt, war ich extrem knapp bei der Zeit. Die Dokumentation (.md) war nicht schwierig. Die grösste Herausforderung war das Vagrantfile. 

Ich kann VMs kreieren, laufen lassen und der Rest funktioniert. Danach habe ich das Konzept "Multi-VMs" mir genauer angeschaut und dies gefolgt. Jetzt funktioniert mein Skript immer noch, aber etwas mit der Reihenfolge der VMs stimmt nicht ganz.



