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
$ rspec
```

### Lancement des tests unitaires front

```
$ bin/rails jasmine
```

Puis ouvrir / rafraîchir le navigateur sur localhost:8888


## Workflow

Voir CONTRIBUTING.md
