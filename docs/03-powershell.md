Automatisation de l'intégration des collaborateurs pour éviter la création manuelle et réduire les erreurs humaines :

* **Script d'importation massive (`.ps1`) :**
  * Lecture automatique d'un fichier source `.csv` contenant les identités des nouveaux employés.
  * Création automatique des comptes utilisateurs Active Directory dans les bonnes UO.
  * Attribution des groupes de sécurité et création dynamique de leur dossier personnel avec droits NTFS adaptés.
 
📜 [Cliquez ici pour consulter le script PowerShell complet](./scripts/ScriptAddUser.ps1)

![Image execution du script PowerShell dans la console](./images/script.png)

![Image résultat des utilisateurs créés dans la console Active Directory](./images/AD.png)

** Difficultés rencontrées / Remarques :**

Recherche de certaines commandes comme l'ajout du lecteur réseau ou au groupe sur internet et intelligence artificiel et utilisation d'un point de contrôle avant l'exécution du script. 
