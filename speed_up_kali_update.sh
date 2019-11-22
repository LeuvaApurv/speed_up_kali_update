echo
echo "------------------------------------------------------------------------------"
echo "#########          speed_up_kali_update.sh - By Leuva Apurv          #########"
echo "#####       https://github.com/LeuvaApurv/speed_up_kali_update.sh        #####"
echo "------------------------------------------------------------------------------"
echo
echo "-------------------- Speed up Kali Linux Update ---------------------"
echo
echo "[+] Backup orignal sources.list to sources.list.bak and create new sources.list" 
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
sudo touch /etc/apt/sources.list
echo
echo "[+] Add best Kali linux repositories in sources.list"
echo
echo "# speed_up_kali_update.sh - By Leuva Apurv" | sudo tee -a /etc/apt/sources.list
echo "deb http://kali.download/kali kali-rolling main contrib non-free" | sudo tee -a /etc/apt/sources.list
echo
echo "[+] Update oand Upgrade Kali Linux"
echo
sudo apt clean
sudo apt update && apt upgrade -y && apt dist-upgrade -y
echo
echo "--------------- Suceessfullly Update your Kali Linux ----------------"
