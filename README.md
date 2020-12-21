# IBM-gd-utils

IBM Cloud Fonudray + gd-utils + Github Actions

### [English Version](#english-version-1)

### 原项目 [gd-utils](https://github.com/iwestlin/gd-utils)


> **效果：用GitHub Actions全自动安装gd-utils机器人到IBM Cloud Fonudray容器内，并且每周五12点定时重启IBM CF**

> **重要提示：因为IBM CF每次重启后容器内应用会恢复原始状态，故重启期间进行的设置和转存记录都会被清除！有这方面需求的谨慎选择是否安装。** （也可能是我的设置问题，有解请告诉我）

>
>前提须知：
>
>1、申请IBM Cloud Fonudray账号，记录下账号和密码。（申请完成后登录就不用管他了，不需要手动建立容器。若安装后出现500错误，原因是容器地址不对，需要登录IBM找到容器设置手动改成us-south.cf.appdomain.cloud的样子，然后检查前面的容器名和你设置的是否一致，改好后重新走第四步）
>
>2、申请tg机器人，记录下token和自己的username(t.me/username)。多个用`username', '其他人的username`这个格式，注意起始处没有引号
>
>3、获得service account文件，并打包成accounts.zip上传到能下载的地方，然后记录下载url（可以直接上传到自己的GoogleDrive）
>
>4、在自己的GD团队盘里面设置一个默认目录，记录下目录ID
>

# 全自动安装

第一步：注册IBM Cloud Fonudray记住账号密码 cloud.ibm.com

第二步：打开GitHub注册，然后Fork本项目（顺便点个Star）

第三步：在你自己的GitHub项目里面点Settings（设置）然后点Secrets（隐私）新建如下内容

Key | Value | Type | Required
-- | -- | -- | --
IBM_MAIL | IBM Cloud的登录邮箱 | Secrets | Yes
IBM_PWD | IBM Cloud的登录密码 | Secrets | Yes
IBM_APP_NAME | CF App的名称（自己取一个） | Secrets | Yes
TG_TOKEN | Telegram机器人token | Secrets | Yes
TG_USERNAME | 你的Telegram username | Secrets | Yes
DRIVE_ID | GD默认保存目录ID | Secrets | Yes
SA_DLURL | SA打包文件accounts.zip下载url | Secrets | Yes


第四步：在你自己的GitHub项目里面，点Actions然后点左侧IBM Cloud Auto Install切换，然后点 Run workflow 开始全自动安装(看不到Auto Install的话，点开yml文件随便加一空行保存)

结束

**打开你自己建的TGbot，输入/help**



# 手动安装

第一步：注册IBM Cloud Fonudray并自行新建容器

第二步：打开IBM Cloud Shell输入以下代码 (shell在网页右上角)

 ```
wget --no-check-certificate -O install.sh https://raw.githubusercontent.com/artxia/IBM-gd-utils/master/install.sh && chmod +x install.sh  && ./install.sh
 ```

结束



# English Version
### by [@ssnjrthegr8](https://github.com/ssnjrthegr8)

<details>
<summary>Stuff</summary>
 
Effect: Use GitHub Actions to automatically install the gd-utils robot into the IBM Cloud Foundry container, and restart IBM CF at 12 o'clock every Friday

Important Note: Because the application in the container will be restored to its original state after each restart of IBM CF, the settings and dump records during the restart will be cleared! If you have this requirement, choose whether to install it carefully. ** (It may also be a problem with my settings, please tell me if you have a solution)

>
>Prerequisites:
>
>1. Apply for an IBM Cloud Foundry account and record the account and password. (After the application is completed, log in and you don’t have to worry about it. You don’t need to manually create the container. If a 500 error occurs after installation, the reason is that the container address is incorrect. You need to log in to IBM to find the container setting and manually change it to us-south.cf.appdomain.cloud , And then check whether the container name in front is consistent with the one you set, and re-take the fourth step after correcting
>
>2. Apply for tg robot, record the token and your username (t.me/username). Multiple use `username','other people's username` format, note that there is no quotation mark at the beginning
>
>3. Obtain the service account file, package it into accounts.zip and upload it to a place where it can be downloaded, and then record the download url (you can upload it directly to your GoogleDrive)
>
>4. Set a default directory in your GD team disk and record the directory ID
>
</details>

# Automatic installation

Step 1: [Sign up for IBM Cloud Foundry](https://cloud.ibm.com/) and note down the emailid and password. Choose your region to be USA for the setup to be of least hassle.

Step 2: Fork this repo.

Step 3: Open your forked repo and go to settings. On your left you will see a tab called Secrets, click that. Click on New Repo Secret and add the key and its respective value one by one. The list is given below:

Key | Value | Type | Required
-- | -- | -- | --
IBM_MAIL | IBM Cloud login email | Secrets | Yes
IBM_PWD | IBM Cloud login password | Secrets | Yes
IBM_APP_NAME | The name of the CF App (take one yourself) | Secrets | Yes
TG_TOKEN | Telegram robot token | Secrets | Yes
TG_USERNAME | Your Telegram username | Secrets | Yes
DRIVE_ID | GD default save directory ID | Secrets | Yes
SA_DLURL | SA package file accounts.zip download url | Secrets | Yes

Step 4: Now go to actions and click on the green I understand my workflow button and on the left you will see IBM auto install, open that. Choose Run Workflow.

Step 5: After the installation has finished, go to https://cloud.ibm.com/resources and click on Cloud Foundry apps. There will be an app with same value you gave for IBM_APP_NAME. Click on the app name and on your upper right there will be an Actions... button. Click that and choose edit routes. Edit it so that it looks like this:
`https://value-of-your-IBM_APP_NAME.us-south.cf.appdomain.cloud/`. If it already looks like that, then skip this step.

![hfgdfg](https://user-images.githubusercontent.com/50513568/102684302-40446200-4212-11eb-9238-8f082e0cbbad.png)

Step 6: Go to your repo > actions > IBM auto restart and enable it, ignore all warnings.

**Open the TGbot you built, and type /help**

<details>
<summary>Manual installation</summary>
Step 1: Register for IBM Cloud Foundry and create a new container by yourself

Step 2: Open the IBM Cloud Shell and enter the following code (shell is in the upper right corner of the page)

 ```
wget --no-check-certificate -O install.sh https://raw.githubusercontent.com/artxia/IBM-gd-utils/master/install.sh && chmod +x install.sh && ./install.sh
 ```
</details>
