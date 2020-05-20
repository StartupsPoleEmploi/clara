# CLARA

**CL**arification des **A**ides pour le **R**etour à l'**A**ctivité.

## Installation



### 0. Prérequis

#### a. Versions de docker et docker-compose

```
$> docker -v
Docker version 17.12.0-ce

$> docker-compose -v
docker-compose version 1.18.0
```

Toute version supérieure devrait fonctionner.

#### b. Port libre

Vérifiez que le port 5432 n'est pas utilisé par ailleurs

```
sudo lsof -i -P -n | grep 5432
```

puis faire un *kill* du process qui utilise ce port.


#### c. Partez d'un état "propre" de docker

Attention, les commandes ci-dessous peuvent supprimer des données de vos autres projets docker.

```
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -q) -f
docker volume prune -f
```


### 1. Téléchargement des projets

Il faut disposer des droits d'accès sur GitHub et Gitlab pour cloner le projet.

```
~$> cd workspace
~/workspace$> mkdir repo && cd repo
~/workspace/repo$> git clone git@github.com:StartupsPoleEmploi/clara.git
```

Cloner le projet "private" du Gitlab de Clara au même endroit

### 2. Lancement du serveur local
```
~/workspace/repo$> cd clara
~/workspace/repo/clara$> docker-compose -f docker-compose-local.yml up --build
```

puis ouvrir un navigateur à l'adresse http://localhost:3000/

la page d'accueil de Clara s'affiche. 

Le site web fonctionne "à minima", car les données de références et les variables d'environnement sont chargées.

Toutefois, il est très compliqué d'effectuer des développements sur une application quasiment vide de données.

Il est conseillé de travailler soit avec les données de production, soit avec un jeu de données simplifié de la base de production (voir ci-dessous)

### 3. Lancer des commandes rails

Vérifiez que les conteneurs docker sont lancés

```
docker-compose -f docker-compose-local.yml run --rm --no-deps web-srv bash
root@0ac2cfcb2722:/railsapp# bundle exec rails --version
Rails 5.2.4.2
```

Toutes les commandes classiques de migration, de console Rails, de lancement de tests unitaires, etc, peuvent ainsi être lancées.


### 4. Mettre la base de données de production en local

Vérifiez que les conteneurs docker sont **stoppés**

```
docker-compose -f docker-compose-local.yml run --rm --no-deps db-srv bash -c "pg_restore --verbose --clean --no-acl --no-owner -U ara -h db-srv -d ara_dev /latest.dump"
```


### 5. Simplifier la base de données

Vérifiez que les conteneurs docker sont **stoppés**

Une version simplifiée de la base de données donne beaucoup de confort de développement : temps de réponse plus rapide, charge mentale du développeur réduite.
Cette version permet également de lancer la suite de test d'intégration, c'est donc celle à privilégier au quotidien lors des développements.

Une fois les données de production chargées en local, vous pouvez effectuer la commande suivante.

```
docker-compose -f docker-compose-local.yml run --rm web-srv bash -c "bundle exec rails minidb:recreate"
```

Lancer la commande **une deuxième fois** pour s'assurer de l'absence d'effets de bords.


### 6. Tests

#### a. Lancer la recette fonctionnelle automatisée

 - Télécharger la version desktop de Cypress https://download.cypress.io/desktop
 - choisissez le répertoire "/workspace/repo/clara/rails"
 - cliquez sur "Run all specs" en haut à droite

#### b. Lancer les tests unitaires "back"

```
~/workspace/repo$> docker-compose -f docker-compose-local.yml run --rm web-srv bash
root@0ac2cfcb2722:/railsapp# bundle exec rails t
# Running:
...........................................................................................................................................................................................................................................................................................................................................................................................................................................................................
Finished in 3.649742s, 125.7623 runs/s, 146.3117 assertions/s.
```

#### c. Lancer les tests unitaires "front"

Ouvrir le navigateur à l'adresse http://localhost:3000/teaspoon/default

Une autre possibilité consiste à lancer la commande suivante :
```
~/workspace/repo$> docker-compose -f docker-compose-local.yml run --rm web-srv bash
root@0ac2cfcb2722:/railsapp# bundle exec rails teaspoon
```



## Recette

### 1. Déploiement en recette

Vous aurez besoin du VPN interne à Pôle Emploi pour déployer en recette

```
~/workspace/repo/private$> ./.execute.sh deploy recette
```

### 2. Restaurer la recette avec des données de production

Mettre à jour latest.dump dans le répertoire "private" du Gitlab et pusher les modifications sur la master.

Puis

```
~/workspace/repo/private$> ./.execute.sh majbd recette
```

### 3. Autres scénariis

```
~/workspace/repo/private$> ./.execute.sh -h
```



## Production

### 1. Déploiement en production

Vous aurez besoin d'une clé SSH pour déployer en production

```
~/workspace/repo/private$> ./.execute.sh deploy production
```

### 2. Dump de base de données

Aller sur la production, puis

```
~$> cd /home/docker/clara
/home/docker/clara$> sudo su
/home/docker/clara$> docker-compose exec -T clara_db bash -c "pg_dump -Fc -U ara --role=ara --dbname=ara_production" > /tmp/clara_dump.dump
```

### 3. Autres scénariis

```
~/workspace/repo/private$> ./.execute.sh -h
```

### 4. Récuperer la base de données de production en local

```
~$> scp dboureau@<addresse-IP-de-la-prod>:/tmp/clara_dump.dump /Users/me/workspace/ 
```


### 5. Montée de version de Ruby

Faire une recherche "plain text" sur le texte suivant

```
FROM ruby:
```

Et remplacer l'ancien numéro de version du Ruby par le nouveau, sur toutes les occurences.
