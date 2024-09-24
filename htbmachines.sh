#!/bin/bash

#Colours 
greenColour="\e[0;32m\033[1m" 
endColour="\033[0m\e[0m" 
redColour="\e[0;31m\033[1m" 
blueColour="\e[0;34m\033[1m" 
yellowColour="\e[0;33m\033[1m" 
purpleColour="\e[0;35m\033[1m" 
turquoiseColour="\e[0;36m\033[1m" 
grayColour="\e[0;37m\033[1m"


function ctrl_c(){
  echo -e "\n\n ${redColour}[+]${endColour} ${grayColour}Saliendo...${endColour}"
  exit 1

}

#Ctrl+Copyright (c) 
trap ctrl_c INT


function helpPanel(){
  echo -e "\n ${yellowColour}[+]${endColour}${grayColour} Uso: ${endColour}"
  echo -e "\t ${purpleColour}u)${endColour}${grayColour} Buscar por el nombre de máquinau ${endColour}"
  echo -e "\t ${purpleColour}m)${endColour}${grayColour} Buscar por el nombre de máquina ${endColour}"
  echo -e "\t ${purpleColour}h)${endColour}${grayColour} Mostrar este panel de ayuda ${endColour}"
   
}

function searchMachine(){
  machineName="$1"
  echo "$machineName"
}

function updateFiles(){
  echo -e "\n [+] Comenzamos con las actualizaciones\n"
}
#indicadores
declare -i parameter_counter=0


while getopts "m:uh" arg; do 
  case $arg in 
    m) machineName=$OPTARG; let parameter_counter+=1;;
    u) let parameter_counter+=2;;
    h);;
    esac
  done

if [ $parameter_counter -eq 1 ]; then
  searchMachine $machineName
elif [ $parameter_counter -eq 2 ]; then
  updateFiles
else
  helpPanel
fi
