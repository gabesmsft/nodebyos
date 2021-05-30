# BYOS Test


## Overview

This application is used for testing the "Bring Your Own Storage" feature on Azure App Service Linux and uses ExpressJS to upload images to the "public/uploads" directory and copies the files to the BYOS mount path specified.  To use with Azure App Service (Linux), add an app setting called "BYOS" with the path used to mount your storage.

`BYOS=/byos/`

This will only work with **Azure Files** which allows read/write operations.

## Testing

There are two options when the app is running "Check Mounted Paths" and "Upload Tests".

### Check Mounted Paths

This uses `node-df` to check the mounted storage devices in the running container and displays it in JSON format.  You can use this to verify the Azure Storage accounts that have been mounted and their mount paths.  Example below.

```json

    "filesystem": "//storageaccountname.file.core.windows.net/filesharename",
    "size": 5368709120,
    "used": 896,
    "available": 5368708224,
    "capacity": 0.01,
    "mount": "/byos"
  },

```

### Upload Tests

You can use this to upload an image which will be stored under `/home/site/wwwroot/public/uploads`.  This is then copied to the mount point that you specified under your Application Setting for "BYOS".  To verify that the image has been uploaded to your Azure File account, you can use Storage Explorer, or you can use the Kudu WebSSH option (i.e. https://sitename.scm.azurewebsites.net/webssh).

In WebSSH change directories to your mounted storage and list the contents.

```bash
  _____
  /  _  \ __________ _________   ____
 /  /_\  \___   /  |  \_  __ \_/ __ \
/    |    \/    /|  |  /|  | \/\  ___/
\____|__  /_____ \____/ |__|    \___  >
        \/      \/                  \/
A P P   S E R V I C E   O N   L I N U X

Documentation: http://aka.ms/webapp-linux
NodeJS quickstart: https://aka.ms/node-qs
NodeJS Version : v12.19.0
Note: Any data outside '/home' is not persisted

root@68f2518de429:/home# cd /byos
root@68f2518de429:/byos# ls -ltra
total 1
-rwxrwxrwx   1 nobody nogroup 4367 May 28 01:59 test.png
drwxr-xr-x 101 root   root    4096 May 28 01:59 ..

```

If the storage account isn't properly mounted, you see a file called `undefined<filename>` under /home/site/wwwroot.

## Deploy to Azure

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftoanms%2Fbyostest%2Fmaster%2Fdeploy.json)
