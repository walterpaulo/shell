#!/bin/bash
#
#decimo.sh - Nosso decimo Progroma em Shell - Script de Backup Completo.
#
# Homepage:
# Autor: Walter Paulo <walter0paulo@hotmail.com>
# Mantenedor: Walter Paulo
#
#--------------------------------------------------------
# 
# Este program sera usado para usado para realizar um backup full de arquivos localizados em um servidor onde  
# teremo que copiar a pasta /srv/samba 
#
# Exemplo de execução:
#
# $ ./backup.sh
#
# Hitórico de Versões
#
# Versão: 1.0
#
# COPYRIGHT: Este programa é GPL

# BAKDIR - Local onde será armazenado os arquvivos de bakcup.
# FILEDIR - Local onde estão os arquivos de origem, que faremos backup.
BKPDIR="/srv/backup/"
FILEDIR="/srv/samba/"
LOGFILE="/var/log/backup.log"
ERROLOG="/var/log/backup_error.log"
DATE=$(date +%d_%m_%Y)
FILENAME="/srv/backuptar_$DATE.tar.gz"
COMPACT="tar -cvzf $FILENAME $BKPDIR"
ADMIN="walter0paulo@hotmail.com"


echo -e "\n"
echo "Iniciando o Script de Backup"
echo -e "\n"

verificar(){
if [ $? -eq 0 ]; then
	echo -e "\e[34mComando ok\e[m\e"
else
	echo "ERRO"
	mail_err
fi

}

mail() {
	sendEmail -f root@unoseg.local -t -m  $ADMIN -u "Mensagem de Backup" -a $LOGFILE
}
mail_err() {
	sendEmail -f root@unoseg.local -t $ADMIN -m "Mensagem de Backup" -a $ERROLOG
}


rsync -avu $FILEDIR $BKPDIR > $LOGFILE 2> $ERROLOG
verificar


[ -f $COMPACT ] || $COMPACT
verificar
mail

exit 0


