# docker-linix-mint
document expliquatif du tp bilan intermédiaire

attention j'ai réalisé mon tp sur un linux mint les depots ne sont pas les memes qu'un debian

je commence par crée un repertoir dans mon github que je nomme docker-linux-mint ou seront exposer mes scripts. dans les fichiers scripts, j'ai commenté les commande pour plus de présition.

#sur les 2 qestions suivante je pouvais le fair un un script c'est à dire installation de docker et l'installation de WP et ZABBIX. mais pour une meilleur visibilité je choisis de faire 2 scripts distint
1) Proposer un script bash install_docker.sh permettant l'installation de docker et docker-compose sur votre VM

dans le docier docker-linux-mint le fichier et nommé docker.install.
je crée le fichier avec la commande #nano docker.install, j'écrie le script et je l'execute. une fois fini je fais #systemctl status docker

2) Installer sur votre VM Wordpress ainsi que Zabbix à l'aide de docker, vous exploiterez le mapping de ports (port de votre choix)

#info git

#pour généré une kye ssh dans mon repertoir 
ssh-keygen -t ed25519 -C "monmail@gmail.com"
#pour voir la clé 
cat ~/.ssh/id_ed25519.pub
#pour lier mon compte git je tape ces commandes
git config --global user.name "monname"
git config --global user.email "monmail@gmail.com"
