#############################################
###### Fonctionnement de l'IPS ##############

Cette IPS traite 3 type d'attaque SYNflood, UDPflood et ICMPflood avec la possibilité de rajouter d'autres traitements d'attaque

## 1 - // IPS.sh ( prog main - étape de Monitoring )

Il joue le rôle d’un orchestrateur qui gère automatiquement l’ordre et le temps d’exécution
de tous les scripts. Il permet de faire la configuration initiale de notre IPS ( il tourne en permanance ). 

Il est aussi responsable de la visualisation complète de ce qui transite sur l’IPS et ainsi obtenir
des informations sur les protocoles utilisés. Il fait aussi la classification des paquets et les
enregistrés dans trois fichiers textes « le fichier TCP.txt pour les paquets TCP avec le
flag SYN, le fichier ICMP.txt pour les paquets ICMP et le dernier pour les paquets UDP ».

## 2 - // SYNflood.sh, UDPflood.sh, ICMPflood.sh ( étape d’Analyse et Réalisation )

Ils prennent l'analyse du trafic selon trois types d'ataque : SYNflood.sh, UDPflood.sh, ICMPflood.sh

Chaques script fait une analyse de tous les paquets et crée un
fichier « CSV » pour les statistique, afin de faire le comptage en gardant une trace de
la date et l’heure de l’arrivée de chaque paquet. Et on utilisant ces données statistiques
notre IPS vérifie l’état du réseau, et dans le cas d’une détection d’intrusion, attaque ou
anomalie, il retourne les paramètres nécessaires pour stopper l’attaque détectée, comme :
IP source de l’attaquant, le numéro de port ciblé, le protocole utilisé...

En cas d'intrusion, ces scripts exécutes des commande pour
alerter l’administrateur, supprimer les paquets malveillants, et bloque les connexions, et
garde une trace de chaque évènement « anomalies, attaques, intrusions » dans un fichier
IPSlog.log
 

------------
Remarque : |
----------------------------------------------------------------------------------------------- 
Ces scripts s’exécutent d’une manière périodique de période 1 seconde « itérative », et       |
l’architecture fonctionnelle de notre solution est basée sur un traitement pipeline de quarte |
blocs « M,C,A et R », or chaque bloc « n » dans l’itération « i » traite les données fournit  |
par le bloc « n-1 » dans l’itération « i-1 ».                                                 |
-----------------------------------------------------------------------------------------------

