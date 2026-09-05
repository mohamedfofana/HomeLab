Sécurisation centralisée du parc de machines et automatisation de l'environnement de travail utilisateur :

* **GPOs de Sécurité (Hardening) :**

  * Politique de mot de passe : Exigence de complexité, 12 caractères min., et verrouillage de compte après 5 tentatives infructueuses (Default Domain Policy).

  * Restriction Outils Système : Blocage de l'accès à l'invite de commande (cmd.exe) et à l'éditeur de registre (regedit.exe) pour les comptes non-admin.

* **GPOs de Configuration Utilisateur :**

  * Mappage de lecteur réseau (Z:) : Montage automatique du partage de fichiers au démarrage.

  * Déploiement Logiciel : Automatisation de l'installation de 7zip .msi au démarrage de la machine.

![Image console gpmc.msc montrant les GPOs créées](./images/gpo.png)


![Image test de restriction et du lecteur réseau Z: sur PC-PROD](./images/gpo_result.png) 

**Difficultés rencontrées / Remarques :**
Recherche de l'emplacement de certaines paramètres de GPO sur internet
