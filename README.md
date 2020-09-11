# Project Feedward - The Hacking Project

## Production

Vous pouvez consulter notre site sur [http://getfeedward.com/](http://getfeedward.com/)

## Description
### 1. Présentation

J’adore ma boite, cependant mon manager n’est pas très à l’écoute. J’ai essayé de lui faire comprendre subtilement, mais rien n’y fait. Je n’ose pas le confronter, et j’ai peur de lui. Je me suis donc dis que je pourrais créer une plateforme qui me permettra de transmettre mes feedbacks, de manière anonyme, ou non, à mon manager, ou aux RH.

### 2. Parcours utilisateur

L’employé s’inscrit/ se connecte sur son compte. Il a la possibilité de remplir un formulaire pour envoyer un feedback. Le destinataire en sera notifié par mail, ainsi que sur son espace.
Le dashboard utilisateur, permet une vue d’ensemble des feedbacks reçus.

Les administrateurs (RH ou managers dans les petites boîtes) ont accès à une vue d’ensemble des feedbacks utilisateurs. Ils peuvent ainsi voir de façon synthétique les feedbacks des employés, par département. Plusieurs feedbacks négatifs peuvent ainsi être détectés.

### 3. Concrètement et techniquement

#### 3.1. Base de données :

Un model Company (name)
Un model User (name, email, phone, job_title, password, company_id)
Admin : boolean
Un model Feedback (sender_id, receiver_id, title, color, text)
Dans une v2, un model Interview (location, date, text)
Une company est reliée à n users et un user ne peut avoir qu’une seule company.

Un user est relié à n feedback et un feedback ne peut avoir que deux users : sender et receiver.

#### 3.2. Front

Devise view pour les utilisateurs (toutes les pages pour le fonctionnement d’un compte)
Des composants pour le dashboard accessible en statut Admin: graphes, diagrammes, outils de statistique classique analysant les résultats des feedbacks (via une utilisation de librairies externes comme chart.js par exemple)
Des formulaires pour les Feedbacks et pour créer un interview
Des cards pour les interviews à venir/ la description des users
#### 3.3. Backend

Service pour faire des statistiques, filtrer, faire des requêtes sur la base de données, puis construire des diagrammes, des graphiques synthétisant l’information.

Un outil Mailer pour informer les users lorsqu’il s’inscrit, il soumet un feedback, il a un rendez-vous à venir ou bien pour les mails d’alerte.
Une méthode pour répartir chaque personne avec son entreprise. Permettra de créer des vues personnalisées pour les employés d’une entreprise.
Un outil Mailer pour informer le user lorsqu’il s’inscrit, il soumet un feedback, il a un rendez-vous à venir.
Un outil pour exporter les dashboards et les rapports d’activité via Google Sheets.
Un service pour se connecter aux calendriers des employés lorsqu’un interview l’impliquant a été créé (pour une v2 avec plus de fonctionnalités).
#### 3.4. Mes besoins techniques

Une personne qui comprend et maîtrise bien la gestion de base de données
Une personne qui a des compétences de front, le goût pour l’UI/UX
Une personne qui aime bien jouer avec les API
Une personne qui sait coder en javascript (pour automatiser certaines parties sur le front et les outils de statistique)
#### 4. La version minimaliste mais fonctionnelle qu'il faut avoir livré la première semaine

La page d’accueil, et toute la partie utilisateurs devra être terminée et fonctionnelle. Les fonctionnalités implantées seront les suivantes :

Possibilité de se connecter (en admin ou user)
Possibilité de recevoir des questionnaires par mail
Possibilité d’envoyer des feedbacks
Une première base de statistique (version minimaliste) sur le dashboard Admin
#### 5. La version que l'on présentera aux jury

Ajouter des nouvelles fonctionnalités (comme la possibilité de créer un événement)
Implanter l’API qui se connecte au calendrier
Avancer sur les statistiques et approfondir le dashboard Admin
#### 6. Le mentor

Comme mentor, nous avons John Bachir, qui est actuellement le directeur technique de Healthie. Nous sommes assez chanceux puisqu'il a été cofondateur et CTO de trois 3 startups qu’il a développé sous Rails.

## Notre Equipe

[Afsaneh SAMET TEHRANI](https://github.com/afsanehs)

[Donnatella GONZALEZ DE LINAIRES](https://github.com/donatellalnrs)

[Yanis MEZIANE](https://github.com/Meyanis95)

[Maxime PIERRON](https://github.com/MaximePierron)

[Tien Duy NGUYEN](https://github.com/tienduy-nguyen)