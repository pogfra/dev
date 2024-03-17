```sh
# Install
brew install dnsmasq

# Create config directory
mkdir -pv $(brew --prefix)/etc/

# Setup *.local (and *.*.local)
echo 'address=/.local/127.0.0.1' >> $(brew --prefix)/etc/dnsmasq.conf

# Change port for High Sierra
echo 'port=53' >> $(brew --prefix)/etc/dnsmasq.conf

# Autostart - now and after reboot
sudo brew services start dnsmasq

# Create resolver directory
sudo mkdir -v /etc/resolver

# Add your nameserver to resolvers
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/local'
```

A ce stade, la commande `nslookup toto.local` devrait donner :

````
Server:         127.0.0.1
Address:        127.0.0.1#53
````

Si l'adresse IP est différente, c'est qu'il manque une adresse dans la liste des serveurs DNS. Pour modifier cette liste, cliquez sur l'icône réseau/wifi, puis `Préférences réseau` > `Avancé...` > `DNS`, la liste de serveurs DNS est à droite.

Si l'adresse `127.0.0.1` existe, vérifiez qu'elle se trouve en première position. Glissez-la tout en haut si ce n'est pas le cas, et enregistrez.

Si l'adresse `127.0.0.1` n'existe pas, notez toutes les adresses présentes, il va falloir les resaisir, et ajouter en première position l'adresse `127.0.0.1`.

Une fois la modification enregistrée, retentez la commande `nslookup toto.local`.
