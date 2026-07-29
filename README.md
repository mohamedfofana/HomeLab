# 🛡️ Maquette d'Infrastructure Entreprise Sécurisée (Homelab AD / pfSense / GPO / Backup)

## 📌 Présentation du Projet
Ce projet consiste en la conception, l'interconnexion et la sécurisation d'une infrastructure réseau et système d'entreprise virtualisée. 
L'objectif est de démontrer les compétences d'**Administration Systèmes et Réseaux (ASR)** : découpage réseau sur pare-feu, annuaire Active Directory, déploiement centralisé par GPO, serveur de fichiers avec gestion des autorisations NTFS, stratégie de sauvegarde d'urgence, script d'automatisation d'intégration de utilisateur à l'AD, serveur web isolé dans une DMZ. Ce projet est réalisé sur Hyper-V

---

## 📐 Architecture & Topologie Réseau

<picture>
  <!-- Image affichée en Mode Sombre -->
  <source media="(prefers-color-scheme: dark)" srcset="./images/Lablanc.drawio.png">
  
  <!-- Image affichée en Mode Clair (par défaut) -->
  <source media="(prefers-color-scheme: light)" srcset="./images/Lab.drawio.png">
  
  <!-- Image de secours si le navigateur ne gère pas la balise -->
  <img alt="Schéma de l'architecture" src="./images/schema-light.png">
</picture>
<br/>  

## 📋 Tableau de Synthèse d'Infrastructure

| Équipement | VM OS | Adresse IP | VLAN Rôle & Services |
| :--- | :---: | :---: | :--- |
| pfSense | FreeBSD | WAN 192.168.1.137 / LAN RoaS | Pare-feu, routage, filtrage |
| PC-ADMIN | Windows Client | DHCP | Poste d'administration |
| SRV-AD | Windows Server |192.168.20.10 |AD, DHCP, DNS, Partage de Fichiers, Backup |
| PC-PROD | Windows Client | DHCP | Simulation poste utilisateurs |
| SRV-WEB | Linux |10.0.40.10 |Serveur Web |



## 🔒 1. Sécurité Réseau & Filtrage (pfSense)
Plutôt que d'autoriser tout le trafic LAN sans restriction, le pare-feu est configuré selon le principe du moindre privilège : <br/>  
• Filtrage des flux entrants/sortants : Suppression des règles permissives de base (Default ANY). <br/>  
• Ouverture ciblée des flux : <br/>  
◦ ACL VLAN ADMIN<br/>  
(image règle admin) <br/>  
◦ ACL VLAN Serveur <br/>  
(image règle srv) <br/>  
◦ ACL VLAN PROD <br/>
(image regle prod) <br/>  
◦ ACL VLAN DMZ <br/>  
(image règle dmz)
NAT/PAT
Relais DHCP

Difficulté rencontré

## 🏢 2. Active Directory & Administration à Distance
• Domaine Active Directory : fofana.lab<br/>  
• Architecture des UO : Découpage structuré (CORP > Utilisateurs, Groupes, Ordinateurs, Serveurs).<br/>  
• Administration Sécurisée : L'administration de l'annuaire est réalisée à 100 % à distance depuis le poste client d'administration via les consoles RSAT (dsa.msc, gpmc.msc), sans session ouverte directement sur le contrôleur de domaine.<br/>  
[📷 CAPTURE : Arborescence des OU dans l'AD et console RSAT]
## 📁 3. Serveur de Fichiers & Autorisations NTFS
• Migration d'Arborescence : Utilisation de l'outil en ligne de commande Robocopy pour migrer les dossiers et préserver l'intégralité des privilèges de sécurité : cmd
robocopy C:\Source C:\Partages /MIR /COPYALL /DCOPY:T

• Mappage Automatisé (GPO) : Distribution automatique du lecteur réseau Z: (\fofana.lab\Donnees) lors de la connexion des utilisateurs.
• Ciblage au niveau de l'élément (Item-Level Targeting) : Seuls les utilisateurs membres des groupes de sécurité autorisés voient monter le lecteur réseau.
[📷 CAPTURE : Explorateur Windows avec le lecteur Z: monté via GPO]
## ⚙️ 4. Durcissement du Parc (Hardening GPOs)
Mise en place de stratégies de groupe (GPO) centralisées pour sécuriser les sessions et les postes clients :
1. Restriction des Outils Système : Blocage de l'accès à l'invite de commande (cmd.exe) et à l'éditeur de registre (regedit.exe) pour les comptes standards.
2. Verrouillage de Session Automatique : Activation obligatoire de l'écran de veille protégé par mot de passe après 5 minutes (300 s) d'inactivité.
3. Politique Anti-Brute-Force (Default Domain Policy) :
• Longueur minimale du mot de passe : 12 caractères.
• Verrouillage du compte après 5 tentatives incorrectes.
1. Déploiement Logiciel Centralisé : Automatisation de l'installation du package .msi (ex: 7-Zip) au démarrage de l'ordinateur.
[📷 CAPTURE : Console gpmc.msc montrant l'application des GPOs] <br/>  
## 💾 5. Plan de Continuité d'Activité (Sauvegarde AD)
Protection de la base de données Active Directory (ntds.dit), du dossier SYSVOL, de la zone DNS et du Registre via la sauvegarde planifiée de l'État du système (System State).
• Outil : Sauvegarde Windows Server (wbadmin).
• Planification : Sauvegarde quotidienne automatique.
• Procédure de reprise après sinistre : Testée et validée via le mode de restauration des services d'annuaire (DSRM).
[📷 CAPTURE : Console Sauvegarde Windows Server avec job System State réussi] <br/>  
## 🕓À Venir
Script PowerShell d'automatisation de création des utilisateurs AD
Serveur Web Linux


