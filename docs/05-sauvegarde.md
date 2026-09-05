Mise en place d'une stratégie de sauvegarde pour le contrôleur de domaine (Active Directory) :

* **Sauvegarde d'État du Système (System State) :**
  * Utilisation de l'outil natif `Windows Server Backup`.
  * Protection intégrale de la base Active Directory, du répertoire `SYSVOL`, du Registre et des zones DNS.
  * Planification automatisée vers un volume disque dédié.

* **Précautions & Bonnes Pratiques appliquées :**
  * Activation de la **Corbeille Active Directory** pour la restauration rapide d'objets supprimés sans interruption de service.
  * Isolement du volume de sauvegarde pour prévenir les altérations.

![Image console de Sauvegarde Windows Server affichant le statut "Réussi"](./images/sauvegarde.png)

**Difficultés rencontrées / Remarques :**
Cette manipulation à nécessité d'ajouter un volume disque virtuel dédié non inclus dans la sauvegarde pour pouvoir stocker l'image System State.
