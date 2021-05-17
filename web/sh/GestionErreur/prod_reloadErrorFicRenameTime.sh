#!/bin/bash


for file in ${BOILERBOX}/web/uploads/fichiers_errors/*; do
        if [ -f "$file" ]; then
                nomFichier=$(echo $file | awk -F '/' '{print $NF}')
                mv $file ${BOILERBOX}/web/uploads/tmp/$nomFichier
        fi
done

# script qui renomme les fichiers du dossier des fichiers en erreur à rejouer : /fichiers_errors/reloads et les déplace dans le dossiers des fichiers d'origines /fichiers_origines/
for file in ${BOILERBOX}/web/uploads/tmp/*; do
        if [ -f "$file" ]; then
                numeroAmodifier=$(echo $file|cut -d '-' -f3|cut -d '.' -f1)
                nouveauNumero=$((10#$numeroAmodifier + 1))
                nb=$(echo $nouveauNumero | wc -c)
                if [ $nb -eq 2 ]; then
                        nouveauNumero="0"$nouveauNumero
                fi
                nouveauNom=$(echo $file|sed 's/\.error//'|sed "s/..\.lci/$nouveauNumero.lci/"|sed "s/\/tmp\//\/fichiers_origines\//")
                mv $file $nouveauNom
        fi
done
