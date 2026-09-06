# 🛡️ Maquette d'Infrastructure Entreprise Sécurisée (Homelab AD / pfSense / GPO / Backup)

## 📌 Présentation du Projet
Ce projet consiste en la conception, l'interconnexion et la sécurisation d'une infrastructure réseau et système d'entreprise virtualisée. 
L'objectif est de démontrer les compétences d'**Administration Systèmes et Réseaux (ASR)** : découpage réseau sur pare-feu, annuaire Active Directory, déploiement centralisé par GPO, serveur de fichiers avec gestion des autorisations NTFS, stratégie de sauvegarde d'urgence, script d'automatisation d'intégration de utilisateur à l'AD, serveur web isolé dans une DMZ. Ce projet est réalisé sur Hyper-V avec pour seul hôte mon PC personnel. 

---

## 📐 Architecture & Topologie Réseau

![Schéma de l'architecture](./images/Lab.drawio.png#only-light)
![Schéma de l'architecture](./images/Labblanc.drawio.png#only-dark)
<br/>  

## 📋 Tableau de Synthèse d'Infrastructure

| Équipement | VM OS | Adresse IP | VLAN Rôle & Services |
| :--- | :---: | :---: | :--- |
| pfSense | FreeBSD | WAN 192.168.1.137 / LAN RoaS | Pare-feu, routage, filtrage |
| PC-ADMIN | Windows Client | DHCP | Poste d'administration |
| SRV-AD | Windows Server |192.168.20.10 |AD, DHCP, DNS, Partage de Fichiers, Backup |
| PC-PROD | Windows Client | DHCP | Simulation poste utilisateurs |
| SRV-WEB | Linux |10.0.40.10 |Serveur Web |
