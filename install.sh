#!/bin/bash
echo
echo "============== <<部署之前先满足以下条件>> =============="
echo "1.你的应用名称"
echo "2.你的应用内存大小"
echo "3.你的应用所在区域"
echo "4.telegram机器人token"
echo "5.telegram账号ID"
echo "6.默认目的google drive团队盘ID"
echo "7.获得SA文件，并打包成accounts.zip文件"
echo "------------------------------------------------"
read -s -n1 -p "已做好准备请按任意键开始"
echo
echo "------------------------------------------------"

SH_PATH=$(cd "$(dirname "$0")";pwd)
cd ${SH_PATH}

create_mainfest_file(){
    echo "进行配置。。。"
    read -p "请输入你的应用名称：" IBM_APP_NAME
    echo "应用名称：${IBM_APP_NAME}"
    read -p "请输入你的应用内存大小(默认256)：" IBM_MEM_SIZE
    if [ -z "${IBM_MEM_SIZE}" ];then
    IBM_MEM_SIZE=256
    fi
    echo "内存大小：${IBM_MEM_SIZE}"
    read -p "请输入你的应用所在区域(不知道的看应用URL，cf前面的us-south就是)：" IBM_APP_REGION
    echo "应用所在区域：${IBM_APP_REGION}"

    read -p "请输入机器人token：" BOT_TOKEN
    while [[ "${#BOT_TOKEN}" != 46 ]]; do
    echo "机器人TOKEN输入不正确，请重新输入"
    read -p """请输入机器人token：" BOT_TOKEN
    done

    read -p "请输入使用机器人的telegram账号ID：" TG_USERNAME
    echo "你的TG账号${TG_USERNAME}"

    read -p "请输入转存默认目的地团队盘ID：" DRIVE_ID
    while [[ "${#DRIVE_ID}" != 19 && "${#DRIVE_ID}" != 33 ]]; do
    echo "你的Google team drive ID输入不正确"
    read -p "请输入转存默认目的地ID：" DRIVE_ID
    done

    cd ~ &&
    sed -i "s/cloud_fonudray_name/${IBM_APP_NAME}/g" ${SH_PATH}/IBM-gd-utils/manifest.yml &&
    sed -i "s/cloud_fonudray_mem/${IBM_MEM_SIZE}/g" ${SH_PATH}/IBM-gd-utils/manifest.yml && 
    sed -i "s/bot_token/${BOT_TOKEN}/g" ${SH_PATH}/IBM-gd-utils/gd-utils/config.js &&
    sed -i "s/your_tg_username/${TG_USERNAME}/g" ${SH_PATH}/IBM-gd-utils/gd-utils/config.js && 
    sed -i "s/DEFAULT_TARGET = ''/DEFAULT_TARGET = '${DRIVE_ID}'/g" ${SH_PATH}/IBM-gd-utils/gd-utils/config.js&&
    sed -i "s/23333/8080/g" ${SH_PATH}/IBM-gd-utils/gd-utils/server.js &&
    sed -i "s@https_proxy='http://127.0.0.1:1086' nodemon@pm2-runtime start@g" ${SH_PATH}/IBM-gd-utils/gd-utils/package.json&&
    sed -i '/scripts/a\    "preinstall": "npm install pm2 -g",' ${SH_PATH}/IBM-gd-utils/gd-utils/package.json&&
    sed -i '/repository/a\  "engines": {\n    "node": "12.*"\n  },' ${SH_PATH}/IBM-gd-utils/gd-utils/package.json&&
    sed -i '/dependencies/a\    "pm2": "^3.2.8",' ${SH_PATH}/IBM-gd-utils/gd-utils/package.json
    echo "配置完成。"
}

clone_repo(){
    echo "进行初始化。。。"
    git clone https://github.com/artxia/IBM-gd-utils
    cd IBM-gd-utils
    git submodule update --init --recursive
    cd gd-utils/sa
    echo "请点击网页右上角的上传功能，上传sa打包成的accounts.zip文件，注意命名和压缩格式要和示例相同"
    read -s -n1 -p "已做好准备请按任意键开始"
    while [ ! -f ${SH_PATH}/accounts.zip ]; do
    echo "。。。。。。上传文件错误，请重新上传"
    read -p "按回车键重试"
    done
    echo "正在解压。。。"
    cp -r ${SH_PATH}/accounts.zip  ${SH_PATH}/IBM-gd-utils/gd-utils/sa/
    unzip -oj accounts.zip
    sleep 10s
    echo "初始化完成。"
}

install(){
    echo "进行安装。。。"
# 解除sudu权限限制
    mkdir ~/.npm-global
    npm config set prefix '~/.npm-global'
    sed -i '$a\export PATH=~/.npm-global/bin:$PATH' ~/.profile
    source ~/.profile
#
    cd IBM-gd-utils/gd-utils
    npm i
    cd ..
    ibmcloud target --cf
    ibmcloud cf push
    echo "安装完成。"
    sleep 3s
	echo "检查是否部署成功。。。"
    echo ${IBM_APP_NAME}.${IBM_APP_REGION}.cf.appdomain.cloud/api/gdurl/count?fid=124pjM5LggSuwI1n40bcD5tQ13wS0M6wg
    curl ${IBM_APP_NAME}.${IBM_APP_REGION}.cf.appdomain.cloud/api/gdurl/count?fid=124pjM5LggSuwI1n40bcD5tQ13wS0M6wg
    curl -F "url=https://${IBM_APP_NAME}.${IBM_APP_REGION}.cf.appdomain.cloud/api/gdurl/tgbot" 'https://api.telegram.org/bot${BOT_TOKEN}/setWebhook'
    echo
}

clone_repo
create_mainfest_file
install
exit 0