# IBM-gd-utils

IBM Cloud Fonudray + gd-utils + Github Actions

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
