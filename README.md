# 🛡️ Maquette d'Infrastructure Entreprise Sécurisée (Homelab AD / pfSense / GPO / Backup)

## 📌 Présentation du Projet
Ce projet consiste en la conception, l'interconnexion et la sécurisation complète d'une infrastructure réseau et système d'entreprise virtualisée. 
L'objectif est de démontrer les compétences d'**Administration Systèmes et Réseaux (ASR)** : découpage réseau strict sur pare-feu, annuaire Active Directory industrialisé, déploiement centralisé par GPO, serveur de fichiers avec gestion fine des autorisations NTFS et stratégie de sauvegarde d'urgence (System State).

---

## 📐 Architecture & Topologie Réseau

```text
               ┌────────────────┐
               │   INTERNET     │
               └───────┬────────┘
                       │ (WAN)
               ┌───────┴────────┐
               │    pfSense     │  <-- Pare-feu (Filtrage strict / Zéro règle ANY)
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
