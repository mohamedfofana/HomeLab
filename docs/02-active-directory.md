Mise en place du cœur de l'annuaire d'entreprise et des services d'infrastructure de base :

* **Services Installés :**
  * **AD DS :** Domaine principal `fofana.lab`.
  * **DNS :** Gestion de la résolution de noms interne et des zones de recherche directe/inverse.
  * **DHCP :** Gestion de l'adressage IP dynamique relayé par pfSense pour les sous-réseaux clients.

![image services](./images/services.png)
![image dns](./images/dns.png)
![image étendu](./images/étendu.png)
![image option dhcp](./images/dhcp.png)

* **Arborescence des Unités d'Organisation (UO) :**
  * Organisation structurée pour préparer l'application des stratégies de groupe (`Fofana` > `Utilisateurs`, `Groupes`, `Ordinateurs`, `Serveurs`).

![Image arborescence des UO dans AD](./images/AD.png)

* **Difficultés rencontrées / Remarques :**
  * Après la création d'une étendu le service DHCP ne s'active pas automatiquement il faut l'activer manuellement
  * Ajout du serveur web après création de celui-ci
  * Ajout d'un serveur DNS publique dans les Redirecteurs 
