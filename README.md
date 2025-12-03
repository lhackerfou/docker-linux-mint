# docker-bilan
document explicatif du tp bilan intermédiaire

attention j'ai réalisé mon tp sur un linux mint, les dépôts ne sont pas les mêmes que sur Debian

je commence par créer un répertoire dans mon github que je nomme docker-linux-mint où seront exposés mes scripts. dans les fichiers scripts, j'ai commenté les commandes pour plus de précision.

#sur les 2 questions suivantes je pouvais le faire en un script, c'est-à-dire installation de docker et l'installation de WP et ZABBIX, mais pour une meilleure visibilité je choisis de faire 2 scripts distincts

1) Proposer un script bash install_docker.sh permettant l'installation de docker et docker-compose sur votre VM

dans le docier docker-linux-mint le fichier est nommé docker.install. je crée le fichier avec la commande #nano docker.install, j'écris le script et je l'exécute. une fois fini je fais #systemctl status docker

2) Installer sur votre VM Wordpress ainsi que Zabbix à l'aide de docker, vous exploiterez le mapping de ports (port de votre choix)

dans le dossier docker-linux-mint le fichier est nommé wp-zabbix.sh. même procédure pour la création du fichier. pour ce script je me suis aidé de l'IA car je n'avais pas vraiment de connaissances en database, mais je me suis renseigné sur chaque partie et j'ai mis des commantaires au ligne du script


#info git

Créer un nouveau repository sur votre github dans lequel vous pousserez votre production.

Pour mon Git, je crée un dossier pour mettre le répertoire GitHub. Je commence par un git init, je génère la clé SSH, je lie mon compte GitHub et je fais un mini-script que je nomme up.sh dans le répertoire docker-linux-mint. Il me suffit ensuite d’exécuter le script et tous mes fichiers remontent sur mon GitHub.

#pour générer une kye ssh dans mon repertoir 

ssh-keygen -t ed25519 -C "monmail@gmail.com"

#pour voir la clé 

cat ~/.ssh/id_ed25519.pub

#pour lier mon compte git je tape ces commandes

git config --global user.name "monname"

git config --global user.email "monmail@gmail.com"
