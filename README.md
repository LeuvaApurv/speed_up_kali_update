# speed_up_kali_update.sh
Speed up Kali Linux Update using this script.

## Requirements
Kali Linux

## Install
```
# git clone https://github.com/LeuvaApurv/speed_up_kali_update
# cd speed_up_kali_update
```
## Usage
Run the script in privilege mode, such that `sources.list` could be edited.

## Sample output:
```
# bash speed_up_kali_update.sh 

------------------------------------------------------------------------------
#########          speed_up_kali_update.sh - By Leuva Apurv          #########
#####       https://github.com/LeuvaApurv/speed_up_kali_update.sh        #####
------------------------------------------------------------------------------

-------------------- Speed up Kali Linux Update ---------------------

[+] Backup orignal sources.list to sources.list.bak and create new sources.list

[+] Add best Kali linux repositories in sources.list

# speed_up_kali_update.sh - By Leuva Apurv
deb http://kali.download/kali kali-rolling main contrib non-free

[+] Update oand Upgrade Kali Linux

Hit:1 http://kali.download/kali kali-rolling InRelease
Reading package lists... Done
Building dependency tree       
Reading state information... Done
All packages are up to date.
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Calculating upgrade... Done
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Calculating upgrade... Done
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.

--------------- Suceessfullly Update your Kali Linux ----------------

```
