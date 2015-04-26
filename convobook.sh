#!/usr/bin/env bash

#Author : Arnaud
#Date : 25/04/15

mkdir -p $HOME/Livres_convertis

function usage {
    echo "Paramètre entré invalide"
    echo "Syntaxe correcte : bash $0 fichier_ou_dossier"
}

function conversion {
  echo "Conversion ($2/$3) : $1"
  filename=$(basename "$1" .epub )
  ebook-convert "$1" $filename.mobi >> ~/Livres_convertis/log.txt
  mv $filename.mobi ~/Livres_convertis
  echo "Termine $filename "
  echo "............................"
}

if [[ ! $# -eq 0 ]]; then
  if [[ -f $1 ]]; then

    filename=$(basename "$1")
    extension="${filename##*.}"

    if [[ $extension == "epub" ]]; then
      cp "$1" ~/Livres_convertis; cd ~/Livres_convertis
      f=`echo $filename | tr " " "_"`
      mv "$filename" $f ;
      conversion $f 1 1
      rm $filename.epub
    else
      usage
    fi
    echo "Livre disponible ici : $HOME/Livres_convertis"

  elif [[ -d $1 ]]; then
    cd $1

    for i in *.epub;
    do
      mv "$i" `echo $i | tr " " "_"` ;
    done

    clear
    nb=$(ls -l *.epub | wc -l)
    j=1

    for i in *.epub;
    do
      conversion $i $j $nb
      j=$(( j + 1 ))
    done
    echo "Livres disponibles ici : $HOME/Livres_convertis"
  else
    usage
  fi
else
  usage
fi
