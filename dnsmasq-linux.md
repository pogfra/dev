Disable systemd-resolve (to free port 53)
```
$ sudo systemctl disable systemd-resolved
Removed /etc/systemd/system/multi-user.target.wants/systemd-resolved.service.
Removed /etc/systemd/system/dbus-org.freedesktop.resolve1.service.
$ sudo systemctl stop systemd-resolved
```

Remove the existing symlink to resolv.conf file
```
$ ls -lh /etc/resolv.conf
lrwxrwxrwx 1 root root 39 Jul 26 2018 /etc/resolv.conf ../run/systemd/resolve/stub-resolv.conf
$ sudo unlink /etc/resolv.conf
```

Create a new `/etc/resolv.conf` file and add local and public DNS servers
```
nameserver 127.0.0.1
nameserver 8.8.8.8
```

Install Dnsmasq
```
$ sudo apt update
$ sudo apt install dnsmasq
```

Add to the bottom of `/etc/dnsmasq.conf`
```
address=/.local/127.0.0.1
port=53
```

Restart dsnmasq
```
$ sudo systemctl restart dnsmasq
```

Then test
```
$ dig site.dev.local
```