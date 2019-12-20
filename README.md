# CLARA

**CL**arification des **A**ides pour le **R**etour à l'**A**ctivité.

## Installation from scratch sur un poste de dev

### Prérequis

Ports 80 et/ou 443 libres
```
~/workspace$> docker --version
Docker version 17.12.0-ce, build c97c6d6

~/workspace$> docker-compose --version
docker-compose version 1.18.0, build 8dd22a9
```


### Installation

#### Liste de commandes pour installer Clara

```

~/workspace$> mkdir clara

~/workspace$> cd clara/

~/workspace/clara$> git clone https://github.com/StartupsPoleEmploi/clara.git

ensuite, le user/mdp sera demandé pour un accès à gitlab pole emploi

~/workspace/clara$> git clone https://git.beta.pole-emploi.fr/clara/private.git

~/workspace/clara$> cd clara/

il faut créér un fichier .env avec au choix pour variable ENV=production|recette| developpement. Si absent, alors docker se lance en mode production

~/workspace/clara/clara$> echo "ENV=recette" >.env

~/workspace/clara/clara$> docker-compose up -d --build

dernière étape, peupler la base de données

~/workspace/clara/clara$> bash ./restore_db_latest.sh

L'application web est lancée.
Le premier lancement nécessitera plusieurs minutes avant mise à disposition de l'interface web

Utiliser un navigateur et l'URL: http://localhost

```
#### Pour arrêter les conteneurs Docker

```
~/workspace/clara/clara$> docker-compose stop
```

#### Pour redémarrer de zéro après arret des conteneurs

```
~/workspace/clara/clara$> docker container prune
```


#### Problèmes possibles d'installation

 - En mode recette, le port 80 de votre machine host doit être libre
 - en mode production les ports 80 et 443 de la machine host doivent être libres

#### Naviguer l'application

L'application est visible sous http://localhost



#### Lancer les tests front

```
~/workspace/clara/clara$> docker-compose exec clara_rails bash -c "cd clara/rails; npm install -g istanbul"
~/workspace/clara/clara$> docker-compose exec clara_rails bash -c "cd clara/rails; bundle exec teaspoon"
```

Vous pouvez aussi vous connecter sous http://localhost/teaspoon/default


#### Lancer les tests de recette

```
~/workspace/clara/clara$> docker-compose exec clara_rails bash -c "cd clara/rails; bin/rails test minidb:recreate"
~/workspace/clara/clara$> docker-compose exec clara_rails bash -c "cd clara/rails; npm install cypress --save-dev"
~/workspace/clara/clara$> docker-compose exec clara_rails bash -c "cd clara/rails; \$(npm bin)/cypress open"
```

lancer tous les tests cypress depuis l'application Cypress

#### Calculer la couverture Ruby

```
~/workspace/clara/clara> docker-compose exec clara_rails bash -c "cd clara/rails; bin/rails test"
```
Permet de lancer tous les tests Ruby, puis range la couverture sous coverage/ruby/unit

```
~/workspace/clara/clara$> docker-compose exec clara_rails bash -c "cd clara/rails; bin/rails minidb:recreate"
~/workspace/clara/clara$> docker-compose exec clara_rails bash -c "cd clara/rails; RAILS_ENV=development COVERAGE_PLEASE=true bin/rails s -p 3000 -b '0.0.0.0'"
~/workspace/clara/clara$> docker-compose exec clara_rails bash -c "cd clara/rails; npm install cypress --save-dev"
~/workspace/clara/clara$> docker-compose exec clara_rails bash -c "cd clara/rails; \$(npm bin)/cypress open"
```

Lancer tous les tests cypress puis arrêter le serveur Rails. La couverture Ruby des tests fonctionnels se trouve alors sous  coverage/ruby/functional

Pour merger les 2 couvertures, 
```
~/workspace/clara/clara> docker-compose exec clara_rails bash -c "cd clara/rails; bin/rails ruby_cov:merge"
```

#### Déployer en recette

##### Installer Clara sur une nouvelle recette vierge


```
~/> mkdir -p /home/docker
~/> cd /home/docker
/home/docker$> git clone https://github.com/StartupsPoleEmploi/clara.git
/home/docker$> git clone https://git.beta.pole-emploi.fr/clara/private.git #login/mdp exigés
/home/docker$> cd clara/
/home/docker/clara$> echo "ENV=recette" >.env
/home/docker/clara$> docker-compose up -d --build
```

##### Déployer une nouvelle version

```
ssh identifiant@adresse_recette

~/$> cd /home/docker/clara
/home/docker/clara$> docker-compose exec clara_rails bash -c "cd clara/rails; git pull; bundle install; bundle exec mina production2 setup"
```

##### Commandes utiles

```
docker-compose down -v
docker-compose up -d
```

##### URL recette

L'application est visible sous https://clara.beta.pole-emploi.fr/

##### URL production

L'application est visible sous https://clara.pole-emploi.fr/

##### URL developpement

L'application est visible sous http://localhost/

### Ecriture d'un test

#### Structure

Il faut obligatoirement 

- zéro à plusieurs given 
- un et un seul when
- un à plusieurs then

Ca doit apparaître en clair avec un commentaire pour séparer les secti∏ons. // given // when // then

#### Déterminisme

Un test doit toujours faire la même chose, de manière prédictive. Par conséquent, il n'est pas possible de tester une fonction aléatoire (lancé de dé par ex.). Il n'est pas possible non plus de parcourir des branches au hasard.


### Outils 
Clara est un projet Open Source sous licence AGPL 3.0. 
Ce statut nous permet d'être soutenu gratuitement. Nous les en remercions.

#### Sentry : error tracking
<p>
  <a href="https://sentry.io">
  <img src="https://sentry-brand.storage.googleapis.com/sentry-logo-black.png" width="150"/>
 </a>
Sentry nous permet de détecter au plus vite les erreurs en production.

</p>

#### Browserstack : Live, Web-Based Browser Testing
<p style="background-color: black;">
 <a href="https://www.browserstack.com/">
  <img src="https://www.browserstack.com/images/layout/browserstack-logo-600x315.png" width="250"/>
 </a>
 Browserstack permet de tester Clara sur différents navigateurs.
</p>

## Workflow

Voir CONTRIBUTING.md
