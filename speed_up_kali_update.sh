#!bin/bash

if [ $(id -u) = "0" ]; then
    echo
else
    echo "You are NOT root user 'use SUDO'"
    exit
fi

#colors
red='\033[1;31m'         # Red
green='\033[1;32m'       # Green
yellow='\033[1;33m'      # Yellow
blue='\033[1;34m'        # Blue
purple='\033[1;35m'      # Purple
reset='\033[0m'       # Text Reset
hv='\033[05m'

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
echo -e "$green 1) Speed up Update"
echo " 2) Update git"
echo " 3) About"
echo " 4) Exit"
echo
echo -e "$blue ______________________"
echo
echo -e "$yellow pick your option$reset"
read h
case "$h" in
1) echo
echo
echo -e "$blue[+] Download mirror list form official kali website"
echo 
echo -e "$blue[+] Getting mirror list$purple"
curl "https://http.kali.org/README.mirrorlist" > kali_repo.txt
sleep 1
grep -oP '>https://\S+kali' kali_repo.txt | sort > mirror.txt 
echo
echo -e "$blue[+] Found a lists of mirrors site:$green"
cat mirror.txt
echo
cat mirror.txt | awk -F/ '{print $3}' | uniq > domain.txt
echo -e "$blue[+] Backup orignal sources.list to sources.list.bak and create new sources.list" 
sudo mv /etc/apt/sources.list /etc/apt/sources.list.backup
sudo touch /etc/apt/sources.list
echo
echo -e "$blue[+] Checking mirrors ... This could take some times"
echo
echo -e "$blue[+] Finding the best latency$purple"
sudo fping -c 5 -q -f domain.txt
echo
echo -e "$yellow[-] Chosse Fastest Mirror [default: https://kali.download/kali] (y/n)? :" 
read d
case "$d" in 
  y|Y ) d="https://kali.download/kali"
	;;
  n|N ) echo
	echo -e "$green[-] Enter Mirror site link :"
	read d;;
    * ) echo
	echo -e "$red[e] Invalid"
	exit;;
esac
echo 
echo "deb $d kali-rolling main contrib non-free" | sudo tee -a /etc/apt/sources.list
echo
echo -e "$blue[+] Update and Upgrade Kali Linux"
echo
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/cache/apt/archives/lock
sudo apt clean 
sudo apt autoremove -y
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y
echo
echo -e "$yellow--------------- Suceessfullly Update your Kali Linux ----------------"
echo 
echo
echo -e "$yellow Creator Of This Script ->> $red $hv  *** Leuva Apurv  *** $reset"
sudo rm -f domain.txt kali_repo.txt mirror.txt
exit
;;
2) echo
echo -e "$blue[+] Updating ..."
echo
git reset --hard > /dev/null
git pull > /dev/null
echo -e "$yellow[+] Updated Successfully $reset"
exit
;;
3) echo
echo
echo
echo -e "$purple                         About"
echo -e "$green     ----------------------------------------------"
echo
echo -e "$blue     I try to do best speed to use during kali update"
echo
echo
echo -e "$yellow Creator Of This Script ->> $red $hv  *** Leuva Apurv  *** $reset"
echo
exit
;;
4) echo -e "$yellow $hv Bye Bye..!!"
	echo -e "$reset"
exit
;;
*) echo -e "$red[e] Invalid"
	exit;;
esac
