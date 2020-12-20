# IBM-gd-utils

IBM Cloud Foundry + gd-utils + Github Actions

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