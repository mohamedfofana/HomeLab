Plutôt que d'autoriser tout le trafic LAN sans restriction, le pare-feu est configuré selon le principe du moindre privilège : <br/>  
 Filtrage des flux entrants/sortants : Suppression des règles permissives de base (Default ANY). <br/>  
* **Ouverture ciblée des flux :** <br/>  
  * ACL VLAN ADMIN<br/>  
![image règle admin](./images/ACL_ADMIN.png) <br/>  
  * ACL VLAN Serveur <br/>  
![image règle srv](./images/ACL_SRV.png) <br/>  
  * ACL VLAN PROD <br/>
![image regle prod](./images/ACL_PROD.png) <br/>  
  * ACL VLAN DMZ <br/>  
![image règle dmz](./images/ACL_DMZ.png)<br/>  
**Traduction d'adresses :** <br/>  
  * Source NAT / Outbound PAT : Mis en place pour permettre à l'ensemble de équipements des différents VLANs privés d'accéder au réseau externe en partageant une unique adresse IP WAN.<br/>  
  * Destination NAT / Inbound PAT : Configuré pour réorienter de manière ciblée le trafic entrant sur des ports spécifiques vers le serveur web situé dans la DMZ. <br/>  

* **Relais DHCP :**
Dans une architecture segmentée en VLANs, les requêtes d'adressage dynamique (DHCP Discover) sont émises sous forme de broadcast, qui sont naturellement bloqués par le routeur de chaque sous-réseau. Un relais DHCP a donc été configuré sur le routeur pour les VLAN Admin et Prod.


**Difficultés rencontrés / Remarques :**
Par défaut le routeur Pfsense bloque les réseaux privé domestique. Lors de la configuration du routeur bien que j'ai désactivé le blocage des adresses privée et bogon. Cependant, par sécurité, l'interface WAN a une politique de filtrage qui bloque tout par défaut ce qui m'empêchait de me connecter sur l'interface WAN. J'ai donc du creer une règle de filtrage autorisant mon PC personnel à s'y connecter.  <br/>  
