# M300 LB2 Ural



## K1 - Toolumgebung
VS Code, Git-Client, Markdown-Editor und SSH-Keys gleichbleibend.

| Kategorie          | Produkt                                              |
| ------------------ | ---------------------------------------------------- |
| Versionsverwaltung | [Git](https://git-scm.com/)                          |
| Hypervisor         | Hyper-V by Windows                                   |
| Container Engine   | [Docker for Windows](https://www.docker.com/)        |
| Editor / IDE       | [Visual Studio Code](https://code.visualstudio.com/) |
| Markdown-Editor    | [Typora](https://typora.io/)                         |

<br>

### Docker Befehle

`docker run`
 startet einen neuen Container, unterstützt zahlreiche Argumente
 `docker ps`
 Übersicht über die aktuellen Container
 `docker images`
 Liste lokaler Images
 `docker rm`
 entfernt einen oder mehrere Container
 `docker rmi`
 löscht die angegebenen Images
 `docker start`
 startet gestoppte Container
 `docker stop`
 stoppt Container
 `docker kill`
 stopp Container sofort (Signal an Hauptprozess)
 `docker logs`
 Container Logs
 `docker inspect`
 Informationen zu Containern
 `docker diff`
 zeigt Änderungen am Dateisystem des Containers
 `docker top`
 Informationen zu laufendem Prozess im Container

### Häufige Befehle

**Docker**

| Befehl         | Beschreibung                                    |
| -------------- | ----------------------------------------------- |
| `docker run`   | Führt einen Befehl in einem neuen Container aus |
| `docker start` | Startet einen oder mehrere Container            |
| `docker stop`  | Stoppt einen oder mehrere Container             |
| `docker build` | Baut eine Image aus dem Dockerfile              |
| `docker pull`  | Lädt Image aus einer Repository herunter        |
| `docker push`  | Lädt Image in eine Repository hoch              |

Wenn man `docker` in die Befehlszeile eingibt, erhält man eine Übersicht aller Befehle. \

**Docker-Compose**

| Befehl                   | Beschreibung                               |
| ------------------------ | ------------------------------------------ |
| `docker-compose build`   | Baut Service auf                           |
| `docker-compose up`      | Erstellt und startet Container             |
| `docker-compose down`    | Stoppt und entfernt Container, inkl. Daten |
| `docker-compose events`  | Real-Time Logs                             |
| `docker-compose kill`    | "Killt" Container (erzwingt Stop)          |
| `docker-compose pause`   | Pausiert Service                           |
| `docker-compose restart` | Startet Service neu                        |
| `docker-compose start`   | Startet Container                          |
| `docker-compose stop`    | Stoppt Container                           |

Wenn man `docker-compose` in die Befehlszeile eingibt, erhält man eine Übersicht aller Befehle.

### Docker for Windows

Im Gegensatz zu LB2 habe ich mich entschieden, [Docker for Windows](https://www.docker.com/) zu installieren, statt eine Linux-VM mit Docker über Vagrant/Virtualbox laufen zu lassen. \
Das aus dem simplen Grund, dass alles nur noch komplizierter wird, wenn ich zusätzlich noch eine VM zwischen mir und den Container habe. Ebenfalls habe ich auch schon von den anderen Mitschülern gehört, dass sie mit der Linux-VM und Docker Probleme haben, da sie zusätzlich noch mit der VM klarkommen müssen.

<br>

### Hyper-V
Und weil ich _Docker for Windows_ verwende, musste ich den Hypervisor von VirtualBox zu Hyper-V von Windows wechseln (andere Hypervisor werden nicht unterstützt). Dazu muss lediglich das Windows-Feature aktiviert werden (mit der Docker-Installtion wird das automatisch aktiviert).


Voraussetzung für Docker und Hyper-V ist, dass man Windows 10 Pro/Education/Enterprise hat. Da Hyper-V nur auf diesen Versionen verfügbar ist.

<br>
<br>

## K2 - Infrastruktur

| Wo        | Link                                                        |
| --------- | ----------------------------------------------------------- |
| GitHub    | https://github.com/uralerkut/M300                           |
| DockerHub | https://cloud.docker.com/repository/docker/uraltbz/m300-lb2 |

<br>

### Containerisierung
Zuvor hatte ich nie grossartig mit Container gearbeitet. Durch die Applikationsentwickler im Betrieb kannte ich schon vorher ein wenig was ein Container ist.

Im Gegensatz zu VMs benötigen Container keine Hypervisor und sind ziemlich ressourcensparend. Sind aber jedoch in gewissen Hinsichten eingeschränkt(er).
Erwähnenswert ist auch, dass sobald ein Container heruntergefahren wird, alle Daten dabei gelöscht werden. Bei einer VM bleiben die Daten im Normalfall bestehen.

Zudem gewährleisten Container die Trennung/Verwaltung der genutzten Ressourcen. Ebenfalls können so Programme ausgeführt werden, welche sich in einer geschützen Umgebung befinden. Sollte etwas schieflaufen (Hacker, Virus, etc.), passiert dem Host-System (und den anderen Containern) nichts.

<br>

### Docker
Docker ist eine OpenSource-Software, welches die Bereitstellung von Anwendungen vereinfacht. Es arbeitet mit Container, welche die Anwendung inkl. Abhänigkeiten beinhalten. Somit ist es ziemlich leicht das Ganze zu transportieren und zu installieren.

Um ein Container auf Docker zu erstellen, muss man ein _Dockerfile_ erstellen (ähnlich wie bei Vagrant). Aber im Gegensatz zu Vagrant enthält es nur einfache Befehle (FROM, COPY, USER, RUN) und kommuniziert mit keinem Hypervisor. Sobald man sein Dockerfile hat, muss das zuerst zu einem Image "gebaut" werden. Anschliessend kann damit ein Container erstellt und gestartet werden. Optional kann man sein Image auch benennen und auf Docker Hub veröffentlichen.



### Microservices

Man unterscheidet heutzutage zwischen zwei Architekturen:

- Monolithische Architektur
- Microservice Architektur

Eine monolithische Applikation kann meist nur _horizontal_ erweitert werden (mehr Leistung --> CPU, RAM, Speicher, etc.). Hingegen ein Microservice sich auch über mehrere Host erweitern lässt (_horizontal_). Zudem können bei einer Microservice-Applikation auch nur die einzelnen Services hochskaliert werden.

Bei Applikationen basierend auf Microservices ist die ganze Applikation in verschiedene kleine "Sub-Applikationen" (sog. _Microservices_) aufgeteilt.

Beispielsweise bei einem Online-Shop benötigt es einen Weboberfläche, die Buchhaltung, den Bestand und die Lieferung.
Diese können nun in 4 Microservices aufgeteilt werden: Weboberfläche, Buchhaltung, Bestand und Lieferung.
Das führt dazu, dass die Programmierung und Wartung der ganzen Applikation einfacher wird, da das Ganze in 4 Services aufgeteilt wurden. Der Nachteil ist, dass eine Schnittstelle für die Kommunikation zwischen den Microservices benötigt wird und dass die Services auch bei Teil-Ausfällen funktionieren müssen.

<br>

## K3 - Container

### Container
Es werden insgesamt 8 Container via `docker-compose.yml` aufgebaut:

| Container | Verwendung              |
| --------- | ----------------------- |
| `db-nc`   | Datenbank für Nextcloud |
| `app-nc`  | Nextcloud Applikation   |
| `web-nc`  | Webserver für Nextcloud |
| `app-pma` | phpMyAdmin              |
| `proxy`   | nginx-Reverse Proxy     |
| `certs`   | Self-signed Zertifikat  |

Es werden dabei keine Dockerfiles genutzt, stattdessen wird alles mittels `docker-compose` gelöst.

<br>

### Volumes
Damit die Daten beim stoppen nicht verloren gehen, werden mittel Volumes persistente Speicher erstellt:

| Volume                    | Nutzung                       |
| ------------------------- | ----------------------------- |
| `db-nc`                   | Speicher für die Nextcloud DB |
| `nextcloud`               | Nextcloud Daten               |
| `./web-nc/nginx.conf`     | nginx.conf für `web-nc`       |
| `certs`                   | Zertifikate                   |
| `./proxy/uploadsize.conf` | uploadsize.conf für `proxy`   |
| `vhost.d`                 | nginx-proxy Daten             |
| `html`                    | nginx-proxy Daten             |
| `/var/run/docker.sock`    | Docker-Daemon Socket (API)    |


<br>

### Netzwerkplan
[![Drawing1.jpg](https://i.postimg.cc/XYmzTGtV/Drawing1.jpg)](https://postimg.cc/pmQCjT27)

Wie im Netzwerkplan ersichtlich - und wie in [K1](#K1) bereits beschrieben - wird Docker nicht in einer VM, sondern direkt auf dem OS laufen gelassen.

#### Netzwerk
Da alle Container mit einem docker-compose.yml gebaut werden, können alle untereinander intern kommunizieren. Wird kein Port oder Netzwerk definiert, können die Container nicht nach aussen interagieren. Beispielsweise müssen alle Webserver (web-nc, app-wp, app-pma) das Netzwerk des Proxys und zusätzlich den "default"-Netzwerk haben, da sie ansonsten keine Verbindung aufbauen können.

<br>

### Schichtenmodell
[![M300lb2-Layer.jpg](https://i.postimg.cc/yYfqr81b/M300lb2-Layer.jpg)](https://postimg.cc/w7sb1HsX)

Das Schichtenmodell zeigt lediglich den Aufbau von _Docker für Windows_. Zu unterst die Infrastruktur/Hardware, danach ein Betriebssysten, Container Engine/Docker und darauf die Container.

<br>

### Umgebungsvariablen

Die Umgebungsvariablen werden entweder direkt im `docker-compose.yml` oder in einem `.env`-File definiert. \
Verwendete Umgebungsvariablen:

| Env-Variable          | Nutzende Container            | Beschreibung                                 |
| --------------------- | ----------------------------- | -------------------------------------------- |
| `MYSQL_ROOT_PASSWORD` | `db-nc`, `app-nc`, `db-wp`    | Root-Passwort für die MariaDB-Datenbank      |
| `MYSQL_PASSWORD`      | `db-nc`, `app-nc`, `db-wp`    | Passwort für den erstellten User             |
| `MYSQL_DATABASE`      | `db-nc`, `app-nc`, `db-wp`    | Zu erstellende Datenbank                     |
| `MYSQL_USER`          | `db-nc`, `app-nc`, `db-wp`    | Zu erstellender User                         |
| `VIRTUAL_HOST`        | `web-nc`, `app-wp`, `app-pma` | Hostname/(Sub-)Domain des Containers (Proxy) |
| `PMA_HOSTS`           | `app-pma`                     | Datenbanken für phpMyAdmin (Container Namen) |
| `SSL_SUBJECT`         | `certs`                       | Domain für das Zertifikat                    |
| `CA_SUBJECT`          | `certs`                       | Antragssteller                               |
| `SSL_KEY`             | `certs`                       | Speicherort .key-File                        |
| `SSL_CSR`             | `certs`                       | Speicherort .csr-File                        |
| `SSL_CERT`            | `certs`                       | Speicherort .crt-File                        |

<br>

### Testfälle
**Testfall 1: Websites aufrufen** 
Voraussetzungen: Container sind gestartet.

| Nr.  | Testfall                                   | Erwartet                                        | Effektiv                          |   OK   |
| :--: | ------------------------------------------ | ----------------------------------------------- | --------------------------------- | :----: |
| 1.1  | Nextcloud aufrufbar: <br>https://localhost | Seite wird geöffnet <br>Keine 500-Fehlermeldung | Seite wird ohne Probleme geöffnet | **OK** |
| 1.2  | phpMyAdmin aufrufbar: <br>http://localhost | Seite wird geöffnet <br>Keine 500-Fehlermeldung | Seite wird ohne Probleme geöffnet | **OK** |


**Testfall 2: Proxy** \
Voraussetzungen: Container sind gestartet.

| Nr.  | Testfall                                       | Erwartet                                                     | Effektiv                           |   OK   |
| :--: | ---------------------------------------------- | ------------------------------------------------------------ | ---------------------------------- | :----: |
|  2.  | Ports 80, 443 offen: <br>HTTP/S-Seite aufrufen | Seiten werden geöffnet <br>Keine Fehlermeldungen (ausser Zerti) | Seiten wird ohne Probleme geöffnet | **OK** |

<br>
<br>

## K4 - Sicherheit

### Service-Überwachung
Für die Container-Überwachung auf _Docker for Windows_ gibt es ein OpenSource-Tool, welches von der Community containisiert wurde: <https://github.com/maheshmahadevan/docker-monitoring-windows>. \
Es beinhaltet Prometheus (Backend) und Grafana (Frontend). Standardmässig gibt es zwei Dashboard: _Docker Host_ und _Docker Containers_. Darin werden bereits mehrere Ressourcen geloggt und grafisch dargestellt.

Zudem lassen sich damit auch Alarme einstellen, so dass bei einer vordefinierten Ereignis eine E-Mail, Slack-Benachrichtigung, etc. gesendet wird. 
Aber damit auch E-Mails versendet werden können, muss der SMTP-Server vorher in der `config.monitoring` definiert werden.

Sobald die Container gestartet sind, kann über <http://localhost:3000/> die Oberfläche aufgerufen werden. User und Passwort ist standardmässig `admin`. 
Anschliessend kann man beispielsweise einen Dashboard öffnen und dort die Auswertungen sehen. Zwar kann man diese über die Benutzeroberfläche bearbeiten, kann sie aber nicht abspeichern. Man muss entweder die Config (wird beim Speichern angezeigt) in die Zwischenablage kopieren, oder speichert es direkt als JSON-Datei ab. Diese Datei wird anschliessend in *./Monitoring/grafana/privisioning/dashboards* gespeichert. \
In meinem Beispiel habe ich ein neues Dashboard _Custom Dashboard.json_, welches auf _Docker Containers.json_ basiert. Ich habe lediglich noch einen Memory Usage-Panel hinzugefügt und daraus ein Alarm erstellt, sollte die Nutzung die 200MB überschreiten. \
**HINWEIS**: Damit die E-Mail versendet wird, muss im `config.monitoring` die SMTP-Daten angegeben werden. Ansonsten funktioniert es nicht.

Alle Dateien und Container befinden sich im Ordner Monitoring.

<br>

### Aktive Benachrichtigung
Wie bereits unter [Service-Überwachung](#Service-Überwachung) beschrieben, habe ich testweise einen Alarm erstellt, welches mir eine E-Mail sendet, sofern die Arbeitsspeicher-Auslastung die 200MB Grenze überschreitet (SMTP-Server muss vorher eingerichtet sein). \

Mit Grafana lässt aber noch viel mehr Benachrichtungen einstellen, wie z. B. Slack-Benachrichtigung, etc. Auch lassen sich diverse Alarme/Benachrichtungen einstellen.

<br>

### Container Absicherung
Um die Container selber abzusichern habe ich folgende Punkte erledigt:

- Non-Root User definiert*
- CPU-Nutzung begrenzt
- Arbeitsspeicher-Nutzung begrenzt
- Restart-Eingeschaft definiert (Was passiert wenn die Contianer sich selber ausschalten)


Der User kann entweder direkt im `docker-compose.yml` oder im Dockerfile definiert werden.
- docker-compose.yml --> `user: "Benutzer:Gruppe"` (siehe Beispiel)
- Dockerfile --> `USER Benutzer` (siehe Beispiel) 


CPU und Arbeitspeicher kann nur im `docker-compose.yml` begrenzt werden (oder direkt per Befehlszeile):

    deploy:
      resources:
        limits:
          cpus: '0.25'
          memory: 256M


Die Restart-Eingeschaft wird im `docker-compose.yml` definiert. Es beschreibt, was passieren soll, sofern ein Container sich selber ausschaltet (sei es durch einen Befehl oder einen Absturz):
    
    restart: <option>

Als `<option>` gibt es: `no`, `always`, `on-failure` oder `unless-stopped` \
Standardmässig verwendet man `always`, sofern der Container nicht von selbst ausgeschaltet werden soll.

<br>

#### Beispiele
- docker-compose.yml
  ```
  db-nc:
    image: mariadb
    container_name: nextcloud-mariadb
    command: --transaction-isolation=READ-COMMITTED --binlog-format=ROW
    restart: always
    volumes:
      - db-nc:/var/lib/mysql
    environment:
      - MYSQL_ROOT_PASSWORD=nextcloud
    env_file:
      - db-nc.env
    user: "mysql:mysql"
    deploy:
      resources:
        limits:
          cpus: '0.25'
          memory: 256M
  ```

- Dockerfile (_`USER appuser`_)
  ```
  FROM nextcloud:fpm-alpine

  RUN addgroup -g 2906 -S appuser && \
      adduser -u 2906 -S appuser -G appuser
  USER appuser
  ```

<br>

\* Es können nicht alle Container als Non-Root User ausgeführt werden, da diese Zugriff auf Systempfade benötigen (ansonsten erscheint die Fehlermeldung "Permission denied"). Möchte man sie dennoch als normalen User ausführen, müsste man solche Container komplett von Grund auf selber aufbauen. Was aus Zeitgründen in diesem Modul nicht möglich ist.


<br>
<br>

## K5 - Allgemein

### 

### Continuous Integration (CI)
Von _Continuous Integration_ (kurz CI) hatte ich zuvor noch nie etwas gehört. 

Jetzt weiss ich, dass CI (vor allem) für die Entwicklung von Software benutzt wird. Dabei wird an der Software "gebastelt" und danach z. B. auf GitHub hochgeladen. Anschliessend testet ein CI-Programm (z. B. _Jenkins_ oder _Travis CI_) mithilfe eines vordefinierten Scripts die hochgeladene Software. Wird gemäss den Scripts einen Fehler gefunden oder es läuft nicht wie geplant, wird die Software als _failed_ markiert. Verläuft alles positiv, wird es als _passed_ markiert.



### Image-Bereitstellung

Die wichtigsten Images sind in meinem Docker Hub und GitHub Repo

| Wo        | Link                                                        |
| --------- | ----------------------------------------------------------- |
| GitHub    | https://github.com/uralerkut/M300                           |
| DockerHub | https://cloud.docker.com/repository/docker/uraltbz/m300-lb2 |

<br>

<br>

### Reflexion
Die ganze LB2 war ziemlich mühsam, das liegt aber unter anderem daran, dass praktisch alles neu war. Bei der LB1 ging es hauptsächlich um Virtuelle Maschinen und deren Automatisierung. Da wir praktisch seit Beginn mit VMs arbeiten, musste ich nur die Automatisierung lernen, was nicht allzu schwer war (Vagrant besteht praktisch nur aus einer Vagrantfile-Datei).

Hingegen bei LB2 musste ich alles von Beginn an lernen, da nicht mehr VMs sondern Container das Hauptthema war. Und zuvor hatte ich noch nie mit Container gearbeitet. Zudem ist Docker und Containerisierung kein einfaches Thema. Zwar gibt es bei Docker auch ein _Dockerfile_-Datei (wie bei Vagrant), aber es besitzt ein anderes Syntax und wird anders gestartet (man baut aus dem Dockerfile zuerst ein Image). 

Zudem kam noch _Docker-Compose_ hinzu, was ich anfangs schon gar nicht verstanden habe. Aber Docker-Compose ist einfach gesagt eine "Erweiterung" von Docker. Damit lassen sich mehrere Container auf einmal erstellen und starten, welche untereinander kommunizieren können. 



