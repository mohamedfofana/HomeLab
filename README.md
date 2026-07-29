# 🛡️ Maquette d'Infrastructure Entreprise Sécurisée (Homelab AD / pfSense / GPO / Backup)

## 📌 Présentation du Projet
Ce projet consiste en la conception, l'interconnexion et la sécurisation complète d'une infrastructure réseau et système d'entreprise virtualisée. 
L'objectif est de démontrer les compétences d'**Administration Systèmes et Réseaux (ASR)** : découpage réseau strict sur pare-feu, annuaire Active Directory industrialisé, déploiement centralisé par GPO, serveur de fichiers avec gestion fine des autorisations NTFS et stratégie de sauvegarde d'urgence (System State).

---

## 📐 Architecture & Topologie Réseau

               ┌────────────────┐
               │   INTERNET     │
               └───────┬────────┘
                       │ (WAN)
               ┌───────┴────────┐
               │    pfSense     │  &lt;-- Pare-feu (Filtrage strict / Zéro règle ANY)
               └───────┬────────┘
                       │ (LAN - 192.168.20.0/24)
        ┌──────────────┴──────────────┐
        │                             │
┌───────┴───────────────┐     ┌───────┴───────────────┐
│ Windows Server (DC1)  │     │ Client Administration │
│  - Active Directory   │     │  - Admin via RSAT     │
│  - DNS / Serveur Fch  │     │  - Client Windows 10  │
│  - Sauvegarde Backup  │     └───────────────────────┘
└───────────────────────┘

<br/>  


## 📋 Tableau de Synthèse d'Infrastructure

| Équipement | VM OS | Service Adresse IP | VLAN Rôle & Services |
| :--- | :---: | :---: | :--- |
| pfSense | FreeBSD | WAN / LAN 192.168.20.1 | Pare-feu, routage, filtrage cerné |
| DC-01 | Windows Server |192.168.20.10 |AD DS, DNS, Partage de Fichiers, Backup |
| CLIENT-ADMIN | Windows Client | 192.168.20.50 | Poste d'administration à distance (RSAT) |


## 🔒 1. Sécurité Réseau & Filtrage (pfSense)
Plutôt que d'autoriser tout le trafic LAN sans restriction, le pare-feu est configuré selon le principe du moindre privilège : <br/>  
• Filtrage des flux entrants/sortants : Suppression des règles permissives de base (Default ANY). <br/>  
• Ouverture ciblée des flux AD : Autorisation stricte des ports indispensables au bon fonctionnement du domaine : <br/>  
◦ DNS : Port 53 (TCP/UDP)<br/>  
◦ Kerberos : Port 88 (TCP/UDP)<br/>  
◦ NTP : Port 123 (UDP)<br/>  
◦ LDAP / LDAPS : Ports 389 / 636 (TCP)<br/>  
◦ RPC Dynamic Ports : Allocation restreinte pour l'administration distante.<br/>  
[📷 CAPTURE : Règles de Pare-feu pfSense ciblées]


##🏢 2. Active Directory & Administration à Distance
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
##⚙️ 4. Durcissement du Parc (Hardening GPOs)
Mise en place de stratégies de groupe (GPO) centralisées pour sécuriser les sessions et les postes clients :
1. Restriction des Outils Système : Blocage de l'accès à l'invite de commande (cmd.exe) et à l'éditeur de registre (regedit.exe) pour les comptes standards.
2. Verrouillage de Session Automatique : Activation obligatoire de l'écran de veille protégé par mot de passe après 5 minutes (300 s) d'inactivité.
3. Politique Anti-Brute-Force (Default Domain Policy) :
• Longueur minimale du mot de passe : 12 caractères.
• Verrouillage du compte après 5 tentatives incorrectes.
1. Déploiement Logiciel Centralisé : Automatisation de l'installation du package .msi (ex: 7-Zip) au démarrage de l'ordinateur.
[📷 CAPTURE : Console gpmc.msc montrant l'application des GPOs] <br/>  
##💾 5. Plan de Continuité d'Activité (Sauvegarde AD)
Protection de la base de données Active Directory (ntds.dit), du dossier SYSVOL, de la zone DNS et du Registre via la sauvegarde planifiée de l'État du système (System State).
• Outil : Sauvegarde Windows Server (wbadmin).
• Planification : Sauvegarde quotidienne automatique.
• Procédure de reprise après sinistre : Testée et validée via le mode de restauration des services d'annuaire (DSRM).
[📷 CAPTURE : Console Sauvegarde Windows Server avec job System State réussi]
