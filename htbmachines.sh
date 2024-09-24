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

#funciones globales
main_url="https://htbmachines.github.io/bundle.js"

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
  
  if [ ! -f bundle.js ]; then
  tput civis
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Descargando archivos necesarios...${endColour}"
  curl -s $main_url > bundle.js
  js-beautify bundle.js | sponge bundle.js
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Todos los archivos han sido descargados${endColour}"
  tput cnorm  
else
     curl -s $main_url > bundle_tmp.js
      js-beautify bundle_tmp.js | sponge bundle_tmp.js
      md5_tpm_value=$(md5sum bundle_tmp.js | awk '{print $1}')
      md5_original_value=$(md5sum bundle.js | awk '{print $1}')
      
      if [ "$md5_original_value" == "$md5_tpm_value" ];then
        echo -e "\n ${yellowColour}[+]${endColour}${grayColour} No hay actualizaciones CRACK :)${endColour}"

      else
        echo -e "${yellowColour}[+]${endColour}${grayColour} hay actualizaciones${endColour}"
        rm bundle.js && mv bundle_tmp.js bundle.js
       fi
  fi
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
