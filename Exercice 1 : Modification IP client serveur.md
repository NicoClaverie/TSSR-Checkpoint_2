## Q.1.1
Adresse IP Serveur : 172.16.10.10/24  
Adresse IP Client : 172.16.100.50/24

![image](https://gist.github.com/assets/161337347/0b38c95d-1e01-4ea5-831f-ce500433073e)  
Le ping ne fonctionne pas, car les deux réseaux ne sont pas sur la même plage IP, en effet le CIDR est en /24 et ne permet que le 4eme octet pour la plage IP

Pour modifier l'adresse IP du client il faut aller dans les parametre, centre réseau et partage, ouvrir ethernet et faire propriétés. 
Dans cette fenetre je change l'IP en 172.16.10.50/24 pour qu'elle soit dans la même plage que le serveur.  
![image](https://gist.github.com/assets/161337347/93eea823-899c-4847-80b5-89cc53608673)  

![image](https://gist.github.com/assets/161337347/1b81cc2c-65cb-4c68-9854-6f88be1f66ce)  
Après le changement, le ping fonctionne correctement

## Q.1.2

Le nom de la machine cliente est `Client1`, le ping effectué s'affiche en IPv6  
![image](https://gist.github.com/assets/161337347/0a714d6e-9ce1-4705-8154-05e5d883a6f5)  

## Q.1.3

Après désactivation de l'IPv6 le ping avec le nom client fonctionne correctement en IPv4, aucune action de ma part n'est nécéssaire pour rectifier cela  
![image](https://gist.github.com/assets/161337347/ac70b768-30bf-497f-8fd8-c51cac5da764)

## Q.1.4

Coté client il faut retourner dans les propriétés Ethernet de la carte réseaux et selectionne `Obtenir une adresse IP automatiquement`  
![image](https://gist.github.com/assets/161337347/2508defc-0920-41ff-b75d-7ce4642cb795)

Coté serveur, il faut aller dans `Tools` puis `DHCP`, selectionner `winserv` puis ouvrir le menu `scope`  
![image](https://gist.github.com/assets/161337347/fc3636f7-0453-40c9-b167-861730bc50ae)  
Sur la VM server le `DHCP` est déjà parametré avec la plage IP `172.16.10.0` dans le `vlan 10`

## Q.1.5

Le client récupère l'IP `172.16.10.20` car le parametrage du DHCP server exclu les adresses de `172.16.10.1` a `172.16.10.19` et `172.16.10.241` a `172.16.10.254`  
La plage disponible est alors comprise entre `172.16.10.20` et `172.16.10.240`
![image](https://gist.github.com/assets/161337347/47302847-44b1-4e5b-8251-ced3aab5f607)

## Q.1.6
Pour que le client ai une IP en `172.16.10.15` il y a deux méthode, soit on change les regles d'exclusion soit on réserve une ip pour une adresse MAC précise, c'est la seconde méthode qui est plus sûr pour avoir l'adresse IP demandé.  
Il faut aller dans la partie `Reservations`puis avec un clique droit faire `New reservations` et donner l'IP `172.16.10.15` avec l'adresse MAC `08-00-27-A8-1A-EA`  
![image](https://gist.github.com/assets/161337347/662e585b-9ec3-4f00-8108-383e6462a43e)

On obtient ça coté serveur  
![image](https://gist.github.com/assets/161337347/e23d0a75-69d8-4065-8abb-496edbad3840)

Coté client on va dans l'`invite de commandes` et on entre les deux commandes `ipconfig /release` et `ipconfig /renew`, la premiere pour resilier le bail DHCP en cours, et la seconde pour refaire une demande auprès du serveur

![image](https://gist.github.com/assets/161337347/5c0c2122-5be0-4adc-8e9d-956e90abfd2f)

## Q.1.7

Vu que je n'ai pas specialement fait de manipulation, je dirait que l'IPv6 est plus permisive que l'IPv4  

## Q.1.8

Oui le serveur DHCP est obsolete 
Pour que le serveur `DHCP` soit actif en IPv6, il suffit de faire un clique droit sur la partie IPv6 de `winserv` et de choisir `New Scope` la suite se parametre un peu comme IPv4, dans le sens ou on choisi quel préfixe utiliser.  
Et bien sûr aller re-activer l'IPv6 sur la machine cliente et cocher la case `Obtenir une adresse IPv6 automatiquement`  



