# Project Feedward - The Hacking Project

## Production
Vous pouvez consulter notre site sur
<span style="font-size: 1.2rem">  [ [http://getfeedward.com](http://getfeedward.com/) ] <span>


<div style="text-align: center; margin-top: 50px; margin-bottom: 50px;">
<img src="app/assets/images/offices/landing-demo.png" alt="landing page">
</div>



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
4. Créer le base de données sur votre machine
   ```bash
    $ rails db:drop
    $ rails db:reset
    $ rails db:create
    $ rails db:migrate
   ```
5. Créer des fausses données avec le seed.rb
   ```bash
    $ rails db:seed
   ```


**Attention** Afin de ne pas nous blacklister de notre mailer, ce serait sympa de commenter la méthode avant de faire votre seed, merci ! **Attention**

# Description
## Présentation

Savez-vous qu'une mauvaise journée au travail suffit pour qu'un emplyé commence à chercher un nouvel emploi ? C’est pour répondre à ce problème que nous avons créé Feedward ! 

Feedward c’est une plateforme de feedbacks pour vos employés et leur bien être. Suivez les retours de vos employés de manière instantanée, et retrouver des insights sur votre dashboard. 


Voici notre vidéo démo qui présente our plateform feedward: [Video démo](https://www.youtube.com/watch?v=R-xO4rONbKM&feature=youtu.be)

## Parcours utilisateur

- Site Feedward landing page: présente toutes les informations nous concernant.

- En tant qu'entreprise
    - Une entreprise s'inscit sur Feedward
    - Une fois inscrite, un compte company manager va être créé avec les informations qui viennent d'être renseignées
    - Le company manager peut accéder à son dashboard manager
    - Dans le dashboard manager, il peut voir des statistiques globales et détaillées de l'entreprise
    - Un manager peut accéder à tous les historiques des feedbacks utilisateurs
    - Un manager peut voir les utilisateurs qui ont le plus de mauvais feedbacks
    - Un manager peut prendre des rendez vous avec des utilisateurs
    - Un manager reçoit des notifications quand un user crée ou modifie son feedback
    - Un manager peut valider ou supprimer la demande de création de compte de l'utilisateur

- En tant qu'utilisateur
    - Un user peut créer et éditer son feedback, une fois par jour
    - Un user peut voir les rendez-vous avec son manager
    - Un user peut utiliser spotify pour écouter de la musique, après avoir soumis un feedback
    - Un user peut regarder les notes globales de son entreprise
    - Un user peut voir l'historique de ses feedbacks

- En tant qu'administrateur du site
    - Un administrateur peut gérer les inscriptions d'une entreprise
    - Un administrateur peut accepter et valider des comptes manager de l'entreprise
    - Un administrateur peut avoir tous les droits qu'ont un utilisateur et un manager d'une entreprise


Si vous créez un nouveau compte entreprise. Vous n'avez pas de données à annalyser. C'est moins intéressant.
C'est pour cela que nous vous fournissons quelques comptes pour tester notre plateforme gratuitement:

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
  



  `Attention: Quand un site admin veut valider ou changer des informations d'utilisateur dans le formulaire. IL ne faut pas laisser la colonne reset_password token vide`

## Base de données

- Model `Company` (name)
- Model `User` (first_name, last_name, email, password, company_id, is_site_admin, is_company_admin, is_validated, confirmed_at, confirmation_sent_at)
- Model `Feedback` (score_global, answer_global, score_workspace, answer_workspace, score_missions, answer_missions, answer_final, sender_id, receiver_id)
- Model `Activity`(name)
- Model `Notification`(activity_id, user_id, feedback_id)
- Model `Appointement`(title, start_date, end_date, description, is_accepted , employee_id, employer_id)


## Frontend

- Design de A-Z de notre site, utiliser [whisical](https://whimsical.com/) pour le design en équipe.
- Génération de bootstrap source 4.5.2 avec `SASS générateur` technologie pour avoir des couleurs personnalisées
- Utilisation Devise pour `users`
- Utilisation [charkick](https://chartkick.com/) et [chart.js](https://www.chartjs.org/) pour faire nos graphes statistiques sur des pages dashboard user et dashboard manager
- Utilisation gem [active admin](https://activeadmin.info/) pour gérer nos pages site admin
- Des composants Atomic pour le feedback formulaire, notification, rendez vous, et des pages statiques
- Utilisation de [flatpickr](https://flatpickr.js.org/) pour avoir une jolie interface pour sélectionner des dates de rendez-vous
- Intégration du chatbox avec scripts chat
- Création d'un darkmode


## Backend

- API backend permet de faire des feedbacks, des statistiques, un mailer, des notifications, des prises de rendez-vous
- API spotify pour écouter de la musique après avoir soumis un feedback
- Site admin avec gem active_admin pour gérer toutes les actions de l'entreprise et des utilisateurs. Il est possible aussi de filtrer et de chercher par rapport aux critères de colonne du model. Il est possible d'exporter des données sous des formats CSV, XML, JSON.
- API intégration de [crisp](https://crisp.chat/en/) pour le chat avec le client

## Version MVP

- La page d’accueil, et toute la partie utilisateurs devra être terminée et fonctionnelle. 
- Possibilité de se connecter (en company admin ou user)
- Possibilité de recevoir des questionnaires par mail
- Possibilité d’envoyer des feedbacks
- Une première base de statistique sur le dashboard Manager

## Version final
- Vous allez trouver la version [ici](http://getfeedward.com)

## Notre mentor

Comme mentor, nous avons John Bachir, qui est actuellement le directeur technique de Healthie. Nous sommes assez chanceux puisqu'il a été cofondateur et CTO de trois 3 startups qu’il a développé sous Rails.

## Notre Equipe


[Afsaneh SAMET TEHRANI](https://github.com/afsanehs)

[Donnatella GONZALEZ DE LINAIRES](https://github.com/donatellalnrs)

[Yanis MEZIANE](https://github.com/Meyanis95)

[Maxime PIERRON](https://github.com/MaximePierron)

[Tien Duy NGUYEN](https://github.com/tienduy-nguyen)

Si vous avez des retours à nous faire, n'hésitez pas ! 
Merci!

