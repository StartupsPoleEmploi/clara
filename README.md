# CLARA

**CL**arification des **A**ides pour le **R**etour à l'**A**ctivité.

## Installation from scratch sur un poste de dev

### Prérequis

```
~/workspace> docker --version
Docker version 17.12.0-ce, build c97c6d6

~/workspace> docker-compose --version
docker-compose version 1.18.0, build 8dd22a9


~/workspace> git clone git@github.com:StartupsPoleEmploi/clara.git

~/workspace> cd clara

~/workspace/clara> git clone ssh://git@git.beta.pole-emploi.fr:23/clara/private.git

~/workspace/clara> rm -rf private/.git

~/workspace/clara> cd docker 

~/workspace/clara/docker> docker-compose -f docker-compose.dev.yml up --build -d

Les machines docker (app, db, nginx) sont lancées, mais pas encore l'application

~/workspace/clara/docker> chmod +x ./scripts/restore_db_dev.sh && ./scripts/restore_db_dev.sh

Désormais la base de données est remplie avec les dernières données issues de la prod.

Dans un autre onglet du terminal, 

~/workspace/clara/docker> docker-compose exec srv_app bash

root@b883dc7f48d5:/home/clara# bin/rails s -p 3000 -b '0.0.0.0'

L'application est visible sous http://localhost

Pour arrêter docker

~/workspace/clara/docker> docker stop $(docker ps -aq)

Pour redémarrer de zéro

~/workspace/clara/docker> docker container prune

```

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
