#!bin/bash

reset='\033[0m'       # Text Reset
hv='\033[05m'	      # blink
purple='\033[1;35m'
green='\033[92m'
red='\e[1;31m'
yellow='\e[1;33m'
blue='\e[1;34m'
orange='\e[38;5;166m'

##############
# Check Root #
##############
if [ $(id -u) != "0" ]; then
   echo
   echo -e "$red" "[ X ]::[NOT root]: You need to be [root] to run this script. "$green" [use SUDO]"
   echo
   sleep 1
   exit
fi

##################################################################################
# First check of setup for internet connection by connecting to google over http #
##################################################################################
echo
echo -e "$yellow" "[ * ] Checking for internet connection"
echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1

if [ $? -ne 0 ]; then
   echo
   echo -e "$red" "[ X ]::[Internet Connection]: OFFLINE!"
   sleep 2
   exit
else
   echo
   echo -e "$green" "[ ✔ ]::[Internet Connection]: CONNECTED!"
   sleep 2
fi

clear 

echo
echo -e "$green--------------------------------------------------------------------------"
echo -e "$yellow######           speed_up_kali_update.sh - By $hv Leuva $hv Apurv  $reset $yellow      ######"
echo -e "$yellow#####       https://github.com/LeuvaApurv/speed_up_kali_update       #####"
echo -e "$green--------------------------------------------------------------------------"
echo
echo -e "$blue-------------------- Speed up Kali Linux Update ---------------------"
echo
echo
echo
echo -e "$green" "1) Speed up Update"
echo " 2) Update git"
echo " 3) About"
echo " 4) Exit"
echo
echo -e "$blue --------------------------"
echo
echo -en "$yellow" "Pick your Option : "
read  h

case "$h" in

1)
  echo
  echo
  echo -e "$blue[ ✔ ] Download mirror list form official kali website"
  echo
  echo -e "$green[ * ] Getting mirror list$purple"
  echo
  curl "https://http.kali.org/README.mirrorlist" > kali_repo.tmp
  sleep 1
  grep -oP '>https://\S+kali' kali_repo.tmp | sort  | uniq > extra_mirror.tmp
  sleep 1
  sed "s/^>//" extra_mirror.tmp > mirror.tmp
  echo
  echo -e "$blue[ ✔ ] Found a lists of mirrors site$green"
  echo
  cat mirror.tmp | awk -F/ '{print $3}' > domain.tmp
  echo -e "$blue[ ✔ ] Backup orignal sources.list to sources.list.bak and create new sources.list"
  sudo mv /etc/apt/sources.list /etc/apt/sources.list.backup
  sudo touch /etc/apt/sources.list
  echo
  echo -e "$green[ * ] Finding the best latency $yellow{ This could take some Time PLEASE WAIT }$purple"
  echo
  sudo fping -c 3 -q -f domain.tmp
  echo
  echo -e "$blue -----------------------------------------------------------------------"
  echo
  echo -e "$green" "1) Use deafult Fastest Mirror site [$blue kali.download $green]"
  echo " 2) Chosee another Mirror site from List"
  echo
  echo -e "$blue ------------------------------------------------------------------------"
  echo
  echo -en "$yellow" "Pick your Option : "
  read apurv
  case "$apurv" in

   1)domain="https://kali.download/kali"
	break;;

   2)echo -e "$green"
	nl -b a domain.tmp
	echo
	echo -en "$yellow[ + ] Choose Mirror site Number from list : "
	read num
	line=$(< domain.tmp  wc -l)
	if ! [[ "$num" =~ ^[1-9]+$ ]]; then
		echo
		echo -e "$red[ X ] Sorry Natural Numbers Only"
		echo
		exit
	fi
	if  [[ "$num" -lt 1 || "$num" -gt "$line" ]]; then
		echo
		echo -e "$red[ X ] Not Allow $green{Only 1 to $line Number Allow}"
		echo
		exit
	fi
	echo
	domain=$(sed "$num!d" mirror.tmp)
   	break;;

   *)echo
	echo -e "$red[ X ] Invalid"
	exit;;
   esac

   echo
   echo "#--------------------------------------------------------------------------#" | sudo tee -a /etc/apt/sources.list
   echo "#######           speed_up_kali_update.sh - By Leuva Apurv           #######" | sudo tee -a /etc/apt/sources.list
   echo "#####       https://github.com/LeuvaApurv/speed_up_kali_update         #####" | sudo tee -a /etc/apt/sources.list
   echo "#--------------------------------------------------------------------------#" | sudo tee -a /etc/apt/sources.list
   echo "" | sudo tee -a /etc/apt/sources.list
   echo "deb $domain kali-rolling main contrib non-free" | sudo tee -a /etc/apt/sources.list
   echo "deb-src $domain kali-rolling main contrib non-free" | sudo tee -a /etc/apt/sources.list
   echo
   echo -e "$green[ * ] Update and Upgrade Kali Linux" "$purple"
   echo
   sudo rm -f /var/lib/dpkg/lock-frontend
   sudo rm -f /var/cache/apt/archives/lock
   sudo apt clean
   sudo apt autoremove -y
   sudo apt update
   echo -e "$green"
   sudo apt upgrade -y
   sudo apt dist-upgrade -y
   echo
   echo -e "$yellow[ ✔✔ ] Suceessfully Update your Kali Linux "
   echo
   echo
   echo -e "$orange" "Creator Of This Script ->> $red $hv  *** Leuva Apurv  *** $reset"
   echo
   sudo rm -f domain.tmp kali_repo.tmp mirror.tmp extra_mirror.tmp final.tmp
   exit
;;

2) echo
   echo -e "$blue[ ✔ ] Updating ..."
   echo
   git reset --hard > /dev/null
   git pull > /dev/null
   echo
   echo -e "$yellow[ ✔ ] Updated Successfully $reset"
   exit
;;

3) echo
   echo
   echo
   echo -e "$yellow                              About"
   echo -e "$green     ----------------------------------------------------------"
   echo
   echo -e "$blue     I try to do best speed to use during Kali Linux Update. $yellow:) "
   echo
   echo
   echo -e "$orange Creator Of This Script ->> $red $hv  *** Leuva Apurv  *** $reset"
   echo
   exit
;;

4) echo
   echo -e "$red $hv Bye Bye..!!"
   echo -e "$reset"
   exit
;;

*) echo -e "$red[ X ] Invalid"
   echo
   exit
;;

esac
