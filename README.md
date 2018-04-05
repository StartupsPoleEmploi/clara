# CLARA

**CL**arification des **A**ides pour le **R**etour à l'**A**ctivité.

## Installation from scratch sur un poste de dev

### Prérequis

 - ruby 2.4.1, installé de préférence avec rbenv
 - postgre 9.5
 - git 2

### Installation

Clonez clara depuis GitHub, puis

```
$ cd clara
$ bundle install
```

Récupérez le fichier d'environnement .env  auprès des administrateurs, puis

```
$ bin/rails db:setup
```


### Lancer le site en local
```
$ bin/rails server
```
le site est disponible sous http://localhost:3000

Dans un autre terminal, lancer

```
$ bundle exec guard -P livereload
```

Pour ne pas avoir besoin de rafraîchir manuellement le navigateur à chaque changement de code.

### Lancement des tests unitaires back

```
$ bundle exec spring rspec
```

### Lancement des tests unitaires front

```
$ bin/rails jasmine
```

Puis ouvrir / rafraîchir le navigateur sur localhost:8888

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
