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
~/workspace$> mkdir repo
~/workspace/repo$> git clone git@github.com:StartupsPoleEmploi/clara.git
~/workspace/repo$> git clone git@git.beta.pole-emploi.fr:23/clara/private.git
ou
~/workspace/repo$> git clone https://git.beta.pole-emploi.frs/clara/private.git
```



### 2. Lancement à minima du serveur local
```
~/workspace/repo$> cd clara
~/workspace/repo/clara$> docker-compose -f docker-compose-local.yml up --build
```

puis ouvrir un navigateur à l'adresse http://localhost:3000/

la page d'accueil de Clara s'affiche. 

Il est désormais possible d'effectuer des développements car les données de référence sont chargées, et les variables d'environnement aussi.

### 3. Lancer des commandes rails
```
~/workspace/repo$> docker-compose -f docker-compose-local.yml run --rm --no-deps web-srv bash
root@0ac2cfcb2722:/railsapp# bundle exec rails --version
Rails 5.2.4.2
```

Toutes les commandes classiques de migration, de console Rails, de lancement de tests unitaires, etc, peuvent ainsi être lancées.




## Déploiement en recette

Vous aurez besoin du VPN interne à Pôle Emploi pour déployer en recette

```
~/workspace/repo/private$> ./.execute.sh deploy recette
```




## Déploiement en production

Vous aurez besoin d'une clé SSH pour déployer en production

```
~/workspace/repo/private$> ./.execute.sh deploy production
```

