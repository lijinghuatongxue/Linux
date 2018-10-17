#! /bin/bash


#System detection
#author liadou
#2018.10.16
#email:woshilijinghua@gmail.com

############################ root check  ###################
[[ $EUID -ne 0 ]] && echo -e "${red}Error:${plain} This script must be run as root!" && exit 1
########################### color viriable ################
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'
########################## sys checjk #################
sys(){
if [ -f /etc/redhat-release ]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
else
    release=""
fi
echo -e  "${yellow}################## system ###############${plain}"
echo -e "${green}Sys:  $release ${plain}"
}
########################## cpu used check #################
cpu(){
idle=`iostat -c |tail -2 |head -1 |awk  '{print $6}'`
num=`lscpu |grep CPU |head -2 |tail -1 |awk '{print $2}'`
echo -e  "${yellow}################## cpu ###############${plain}"
echo -e  "${green}Cpu idle: "$idle"%${plain}"
}
########################## memory check ###################
mem_total=`free -m |grep Mem |awk '{print $2}'`
mem_used=`free -m |grep Mem |awk '{print $3}'`
mem_rate=0`echo "scale=3;$used/$total" | bc`
######################### swap chack ####################
swap_total=`free -m |grep Swap |awk '{print $2}'`
swap_used=`free -m |grep Swap |awk '{print $3}'`
swap_rate=0`echo "scale=3;$swap_used/$swap_total" | bc`

######################## disk IO check ##################

sys;
cpu;
echo -e  "${yellow}################## swap ###############${plain}"
echo -e "${green}Swap: "$swap_total"M;  Used: "$swap_used"M;  Rate: $swap_rate ${plain}"
echo -e "${green}Used: "$swap_used"M${plain}"
echo -e "${green}Rate: $swap_rate ${plain}"
echo -e  "${yellow}################## memory ###############${plain}"
echo -e "${green}Memory: "$mem_total"M;  Used: "$mem_used"M;  Rate: $mem_rate ${plain}"
echo -e "${green}Used: "$mem_used"M ${plain}"
echo -e "${green}Rate: $mem_rate ${plain}"
