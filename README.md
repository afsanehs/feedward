# Project Feedward - The Hacking Project

## Production

Vous pouvez consulter notre site sur
<span style="font-size: 1.2rem">  [ [http://getfeedward.com](http://getfeedward.com/) ] <span>



## Installation

Notre application utilise Ruby 2.5.1, rails 6.0.3 et postgres-12

Pour installer et lancer le server en local: 
1. Installer gem dépendantes: 
    ```bash
      $ bundle install
    ```
2. Installer js packages
   ```bash
    $ yarn
    $ npm install
   ```
3. Installer `chart.js` et `chartkick` 
   ```bash
    $ yarn add chartkick chart.js
   ```
4. Create le base de donné sur votre machine
   ```bash
    $ rails db:drop
    $ rails db:reset
    $ rails db:create
    $ rails db:migrate
   ```
5. Créer des faux données avec le seed.rb
   ```bash
    $ rails db:seed
   ```


# Description du projet
## Présentation

J’adore ma boite, cependant mon manager n’est pas très à l’écoute. J’ai essayé de lui faire comprendre subtilement, mais rien n’y fait. Je n’ose pas le confronter, et j’ai peur de lui. Je me suis donc dis que je pourrais créer une plateforme qui me permettra de transmettre mes feedbacks, de manière anonyme, ou non, à mon manager, ou aux RH.

## Parcours utilisateur

L’employé s’inscrit/ se connecte sur son compte. Il a la possibilité de remplir un formulaire pour envoyer un feedback. Le destinataire en sera notifié par mail, ainsi que sur son espace.
Le dashboard utilisateur, permet une vue d’ensemble des feedbacks reçus.

Les administrateurs (RH ou managers dans les petites boîtes) ont accès à une vue d’ensemble des feedbacks utilisateurs. Ils peuvent ainsi voir de façon synthétique les feedbacks des employés, par département. Plusieurs feedbacks négatifs peuvent ainsi être détectés.


Nous vous fournissons quelquel compte pour tester gratuitement:

- Compte site admin
  <details>
  <summary>Admin</summary>
  email: site_admin@yopmail.com

  password: 0123456789 
  </details>


- Compte company manager
   <details>
  <summary>Company manager 1</summary>
  email: company_admin_1@yopmail.com

  password: 0123456789 
  </details>

   <details>
  <summary>Company manager 2</summary>
  email: company_admin_2@yopmail.com

  password: 0123456789 
  </details>

  <details>
  <summary>Company manager 3</summary>
  email: company_admin_3@yopmail.com

  password: 0123456789 
  </details>


- Compte tester
   <details>
  <summary>Tester 1</summary>
  email: jean_dupont_1@yopmail.com

  password: 0123456789 
  </details>

   <details>
  <summary>Tester 2</summary>
  email: jean_dupont_2@yopmail.com

  password: 0123456789 
  </details>

  <details>
  <summary>Tester 3</summary>
  email: jean_dupont_3@yopmail.com

  password: 0123456789 
  </details>
  

## Base de données

- Model `Company` (name)
- Model `User` (first_name, last_name, email, password, company_id, is_site_admin, is_company_admin, is_validated, confirmed_at, confirmation_sent_at)
- Model `Feedback` (score_global, answer_global, score_workspace, answer_workspace, score_missions, answer_missions, answer_final, sender_id, receiver_id)
- Model `Activity`(name)
- Model `Notification`(activity_id,user_id, feedback_id)
- Model `Appointement`(title,start_date,end_date, description, is_accepted , employee_id, employer_id)


## Frontend

- Dessiner de A-Z notre site, utiliser [whisical](https://whimsical.com/) pour le design en équipe.
- Générer bootstrap source 4.5.2 avec `SASS générateur` technologie pour avoir des couleurs personnalisées
- Utiliser Devise pour `users`
- Utiliser [charkick](https://chartkick.com/) et [chart.js](https://www.chartjs.org/) pour faire nos graphes statistiques sur des pages dashboard user et dashboard manager
- Utiliser gem [active admin](https://activeadmin.info/) pour gérer nos pages site admin
- Des composant Atomic pour le feedback formulaire, notification, rendez vous, et des pages statiques
- Utiliser [flatpickr](https://flatpickr.js.org/) pour avoir une jolie interface pour sélectionner des dates de rendez-vous
- Intégrer le chatbox avec scripts chat
- Darkmode


## Backend

- API backend permet de faire de feedbacks, statistiques, mailer, notifications, rendez-vous
- API spotify pour écouter de la musique
- Site admin avec gem active_admin Gérer tous les actions de l'entreprise et des utilisateurs. Il est possible aussi de filtre et de chercher par rapport des critères de colonne du model. Il est possible d'exporter des données sous des format CSV, XML, JSON.
- API intégration de crips pour le chat avec client

## Version MVP

- La page d’accueil, et toute la partie utilisateurs devra être terminée et fonctionnelle. 
- Possibilité de se connecter (en company admin ou user)
- Possibilité de recevoir des questionnaires par mail
- Possibilité d’envoyer des feedbacks
- Une première base de statistique sur le dashboard Manager

## Version final
- Vous allez trouver [ici](http://getfeedward.com)

## Notre mentor

Comme mentor, nous avons John Bachir, qui est actuellement le directeur technique de Healthie. Nous sommes assez chanceux puisqu'il a été cofondateur et CTO de trois 3 startups qu’il a développé sous Rails.

## Notre Equipe


[Afsaneh SAMET TEHRANI](https://github.com/afsanehs)

[Donnatella GONZALEZ DE LINAIRES](https://github.com/donatellalnrs)

[Yanis MEZIANE](https://github.com/Meyanis95)

[Maxime PIERRON](https://github.com/MaximePierron)

[Tien Duy NGUYEN](https://github.com/tienduy-nguyen)

Merci!

