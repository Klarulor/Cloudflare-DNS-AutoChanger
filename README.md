# Cloudflare DNS Auto-Changer

# Installation
```
$ git clone https://github.com/Klarulor/Cloudflare-DNS-AutoChanger
$ chmod 777 ./updateDNS.sh
```

# Launching
If you want to add script to autorun
```
$ crontab -e
```
Then choice the first
Add the following line to crontab file.

```
@reboot sudo *YOUR PATH TO FILE*/updateDNS.sh &
```
or with args
```
@reboot sudo *YOUR PATH TO FILE*/updateDNS.sh --zoneId=abcdefgh --token=TOKEN --domain=example.com --dnsRecord=super-api. --email=example@gmail.com &
```

# Configuration
You can configure config in script or you can run script with enviroment variables

**RUN**
```
$ ./updateDNS.sh --zoneId=abcdefgh --token=TOKEN --domain=example.com --dnsRecord=super-api. --email=example@gmail.com
```
