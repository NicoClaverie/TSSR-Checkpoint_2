## Q.1.1
Adresse IP Serveur : 172.16.10.10/24  
Adresse IP Client : 172.16.100.50/24

![image](https://github.com/NicoClaverie/TSSR-Checkpoint_2/assets/161337347/def7b986-a45b-4cf0-873a-e12d18724760)  

Le ping ne fonctionne pas, car les deux réseaux ne sont pas sur la même plage IP, en effet le CIDR est en /24 et ne permet que le 4eme octet pour la plage IP

Pour modifier l'adresse IP du client il faut aller dans les parametre, centre réseau et partage, ouvrir ethernet et faire propriétés. 
Dans cette fenetre je change l'IP en 172.16.10.50/24 pour qu'elle soit dans la même plage que le serveur.  
![image](https://github.com/NicoClaverie/TSSR-Checkpoint_2/assets/161337347/8e28de91-eb86-449f-8b13-8720972be210)  
 

![image](https://github.com/NicoClaverie/TSSR-Checkpoint_2/assets/161337347/48776763-169e-4052-8258-1c9cfedfada8)  
  
Après le changement, le ping fonctionne correctement

## Q.1.2

Le nom de la machine cliente est `Client1`, le ping effectué s'affiche en IPv6  
![image](https://github.com/NicoClaverie/TSSR-Checkpoint_2/assets/161337347/717950f6-1102-4b0e-8f3b-77177a372fa8)  


## Q.1.3

Après désactivation de l'IPv6 le ping avec le nom client fonctionne correctement en IPv4, aucune action de ma part n'est nécéssaire pour rectifier cela  
![image](https://github.com/NicoClaverie/TSSR-Checkpoint_2/assets/161337347/b2e65e26-1459-4b5d-8ecb-f8ff08e0a490)  


## Q.1.4

Coté client il faut retourner dans les propriétés Ethernet de la carte réseaux et selectionne `Obtenir une adresse IP automatiquement`  
![image](https://github.com/NicoClaverie/TSSR-Checkpoint_2/assets/161337347/232709f7-864b-474d-8c67-2fdcc28888d3)


Coté serveur, il faut aller dans `Tools` puis `DHCP`, selectionner `winserv` puis ouvrir le menu `scope`  
![image](https://github.com/NicoClaverie/TSSR-Checkpoint_2/assets/161337347/5ae7ccda-ddfe-4a7b-9bc3-b4b2b739042a)
  
Sur la VM server le `DHCP` est déjà parametré avec la plage IP `172.16.10.0` dans le `vlan 10`

## Q.1.5

Le client récupère l'IP `172.16.10.20` car le parametrage du DHCP server exclu les adresses de `172.16.10.1` a `172.16.10.19` et `172.16.10.241` a `172.16.10.254`  
La plage disponible est alors comprise entre `172.16.10.20` et `172.16.10.240`
![image](https://github.com/NicoClaverie/TSSR-Checkpoint_2/assets/161337347/0a3af3b4-4cee-4b68-be48-dd3e5d5aa94a)


## Q.1.6
Pour que le client ai une IP en `172.16.10.15` il y a deux méthode, soit on change les regles d'exclusion soit on réserve une ip pour une adresse MAC précise, c'est la seconde méthode qui est plus sûr pour avoir l'adresse IP demandé.  
Il faut aller dans la partie `Reservations`puis avec un clique droit faire `New reservations` et donner l'IP `172.16.10.15` avec l'adresse MAC `08-00-27-A8-1A-EA`  
![image](https://github.com/NicoClaverie/TSSR-Checkpoint_2/assets/161337347/89c4c012-deab-4780-85ff-787490a03e7a)


On obtient ça coté serveur  
![image](https://github.com/NicoClaverie/TSSR-Checkpoint_2/assets/161337347/ae181d6c-d511-433b-b843-4e5b1337c972)


Coté client on va dans l'`invite de commandes` et on entre les deux commandes `ipconfig /release` et `ipconfig /renew`, la premiere pour resilier le bail DHCP en cours, et la seconde pour refaire une demande auprès du serveur

![image](https://github.com/NicoClaverie/TSSR-Checkpoint_2/assets/161337347/54bbe24e-4918-45a9-bdc7-d9793e6f60a7)


## Q.1.7

Vu que je n'ai pas specialement fait de manipulation, je dirait que l'IPv6 est plus permisive que l'IPv4  

## Q.1.8

Oui le serveur DHCP est obsolete 
Pour que le serveur `DHCP` soit actif en IPv6, il suffit de faire un clique droit sur la partie IPv6 de `winserv` et de choisir `New Scope` la suite se parametre un peu comme IPv4, dans le sens ou on choisi quel préfixe utiliser.  
Et bien sûr aller re-activer l'IPv6 sur la machine cliente et cocher la case `Obtenir une adresse IPv6 automatiquement`  



