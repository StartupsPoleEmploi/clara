# CLARA

**CL**arification des **A**ides pour le **R**etour à l'**A**ctivité.

## Installation

Il faut disposer des droits d'accès sur GitHub et Gitlab pour installer le projet.

```
~$> cd workspace
~/workspace$> mkdir repo
~/workspace/repo$> git clone git@github.com:StartupsPoleEmploi/clara.git
~/workspace/repo$> git clone git@git.beta.pole-emploi.fr:23/clara/private.git
```

## Déploiement en recette

Vous aurez besoin du VPN interne à Pôle Emploi pour déployer en recette

```
~/workspace/repo$> cd private
~/workspace/repo$> ./.execute.sh deploy recette
```

## Déploiement en production

Vous aurez besoin d'une clé SSH pour déployer en production

```
~/workspace/repo$> cd private
~/workspace/repo$> ./.execute.sh deploy production
```

