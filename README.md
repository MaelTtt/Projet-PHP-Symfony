# Projet Symfony - Gestion d'Événements

Ce projet est une application web développée avec le framework PHP Symfony. Elle permet aux utilisateurs de créer, gérer, s'inscrire et participer à des événements.

## Fonctionnalités

- **Inscription et authentification des utilisateurs**
- **Création et gestion d'événements**
- **Inscription et désistement aux événements**
- **Notifications par email après inscription/désistement**
- **Gestion des autorisations et sécurité**
- **Services personnalisés et injection de dépendances**
- **Tests unitaires et fonctionnels**

## Prérequis

- PHP 8.1 ou plus récent
- Composer
- Node.js et Yarn

## Installation

1. Clonez le répertoire du projet :

```bash
git clone https://github.com/MaelTtt/Projet-PHP-Symfony.git
```

2. Lancer le docker-compose :

```bash
docker-compose up -d
```

3. Une fois les conteneurs démarrés, allez dans le conteneur PHP :

```bash
docker exec -it projet_symfony_php bash
```

4. Aller dans le projet :

```bash
cd Projet
```

5. Lancez le serveur de développement :

```bash
symfony server:start
```

