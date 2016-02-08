# Dillinger

This script automates renewing your Let's Encrypt SSL certificate. 

### Requirements
- git
- A working Apache HTTP server OR
- Access to the webroot for each domain being authenticated OR
- Ability to open port 80 to the outside world

### Installation

```sh
$ sudo git clone https://github.com/letsencrypt/letsencrypt /usr/share/letsencrypt
$ sudo mkdir /etc/letsencrypt
```

##### 1. Copy standalone.ini or webroot.ini based on your configuration

```sh
$ sudo cp webroot.ini /etc/letsencrypt/YOURDOMAIN.com.ini
```

##### 2. Edit /etc/letsencrypt/YOURDOMAIN.com.ini to match your settings. Add all subdomains that you need. Leave test mode enabled to make sure your settings are correct.

```sh
$ sudo mkdir /root/bin ; sudo cp autorenew-letsencrypt-cert.sh /root/bin
```

##### 3. Edit root's crontab to make this run monthly. Add the contents from the "crontab" file in this repo.

```sh
$ sudo crontab -e
```

##### 4. Run the script.

```sh
$ sudo /root/bin/autorenew-letsencrypt-cert.sh mydomain.com
```

##### 5. If your configuration is correct, edit /etc/letsencrypt/YOURDOMAIN.com.ini and comment out the following line:

```
; server = https://acme-staging.api.letsencrypt.org/directory
```

##### 6. Run the script again, but this time in live mode!

```sh
$ sudo /root/bin/autorenew-letsencrypt-cert.sh mydomain.com
```

##### 7. Have fun! :)
