# Serveurs de développement (Traefik/MariaDB/MailHog)

Ce projet permet l'installation d'un environnement de développement basé sur docker.

- [Treafik](https://doc.traefik.io/traefik/) est reverse-proxy supportant le montage automatisé des images docker, le routage web/tcp/udp par domaine, et le support ssl.
- [MariaDB](https://mariadb.org/) est le serveur de base de données relationnelles, fork open-source de MySQL.
- [MailHog](https://github.com/mailhog/MailHog) est un outil de test d'e-mail qui permet d'installer et de configurer très facilement un serveur d'e-mail local, utilisé lors du développement pour ne pas envoyer réellement les mails.

## 1. Installation de dnsmasq

[dnsmasq](https://thekelleys.org.uk/gitweb/?p=dnsmasq.git;a=summary) permet la résolution des domaines locaux sans intervention sur le fichier /etc/hosts. Il est également possible d'utiliser des sous-domaines avec wildcard (*.local).

- Sur Mac : voir le fichier dsnmasq-mac.md
- Sur Linux : voir le fichier dsnmasq-linux.md

## 2. Installation mkcert

[mkcert](https://mkcert.dev/) est un outil simple qui peut être utilisé pour fabriquer des certificats de confiance localement.

- Sur Mac :

```sh
brew install mkcert
brew install nss # pour Firefox
```

- Sur Linux (ou windows) :

```sh
# installation de certutil
sudo apt install libnss3-tools -y

# téléchargement du binaire, à adapter selon la version et l'architecture
# https://github.com/FiloSottile/mkcert/releases
wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64

# déplacement
sudo mv mkcert-v1.4.3-linux-amd64 /usr/local/bin/mkcert

# droit d'exécution
sudo chmod +x /usr/local/bin/mkcert
```

## 3. Création du certificat pour traefik

Install du certicat racine

```sh
mkcert -install
```

Puis la génération du certificat wildcard pour traefik (depuis la racine du projet)

```sh
mkcert -cert-file data/traefik/dev.cert -key-file data/traefik/dev.key "*.dev.local"
```

**Note**: Bien que techniquement possibles, les certificats auto-signés de second niveau (`*.local` par exemple) sont généralement bloqués par les navigateurs.

**Note**: Un certificat wildcard est valable uniquement pour le niveau de domaine spécifié, pas pour les sous-domaines enfants. `*.dev.local` est valable pour un domaine `monprojet.dev.local`, mais pas pour `fr.monprojet.dev.local` par exemple. Il est par contre tout à fait possible de générer à nouveau le certificat en ajoutant une liste de domaines suplémentaires si nécessaire, par exemple :

```sh
mkcert -cert-file data/traefik/dev.cert -key-file data/traefik/dev.key "*.dev.local" "*.monprojet.dev.local"
```

**Note**: Le changement de certificats ne nécessite pas de redémarrage de Traefik, cette modification fait partie de la configuration dynamique du serveur, elle est gérée "à chaud".

## 4. Lancement des serveurs

Le lancement des serveurs est réalisé depuis docker-compose, à la racine du projet.

```sh
# avec les logs... (ctrl+c pour quitter)
docker-compose up

# ...ou en arrière-plan, en daemon
docker-compose up -d

# tout stopper
docker-compose down
```

- Traefik  : https://traefik.dev.local/
- MailHog : https://mailhog.dev.local/
- MariaDB :
    - depuis un client local (sequel, dbeaver,...) : `localhost:3307` ou `127.0.0.1:3307`
  	  
      `mysql -uroot -proot --host=localhost --port=3307`
  
    - depuis un container, `mysql:3306`
