# SSL-Pinning

## Option 1

**Step 1**
```bash
# Downlaod frida-server
wget https://github.com/frida/frida/releases/download/16.0.10/frida-server-16.0.10-android-x86.xz
xz -d frida-server-16.0.10-android-x86.xz
mv frida-server-16.0.10-android-x86 frida-server

# connect to adb
adb connect 192.168.31.103:5555
adb push frida-server /data/local/tmp
adb shell

# run frida-server
su 
cd /data/local/tmp
chmod +x frida-server
./frida-server &
```

**Step 2**
```
objection --gadget "com.android.settings" device-type
```

If the result is the same as below, then the objection agent successfully installed on the device:
```bash
Using USB device `Nexus 6`
Agent injected and responds ok!
Connection: USB
Name: com.android.settings
System: vbox86p
Model: Google
Version: 10
Asking jobs to stop...
Unloading objection agent...
```

**Step 3**
Get the target running application
```bash
frida-ps -Uia
```

In this case, im trying to get SSL-Pinning on Guidebook
```bash
 PID  Name                  Identifier
4  --------------------  --------------------------------
3501  Counter               com.example.counter
6567  Files                 com.android.documentsui
1715  Google Play Store     com.android.vending
5060  Guidebook             com.guidebook.android
6142  Manager               com.example.manager
6303  Search                com.android.quicksearchbox
7680  Settings              com.android.settings
6346  WebView Shell         org.chromium.webview_shell
   -  Amaze                 com.amaze.filemanager
   -  Calendar              com.android.calendar
   -  Camera                com.android.camera2
   -  Clock                 com.android.deskclock
   -  Contacts              com.android.contacts
   -  Custom Locale         com.android.customlocale2
   -  Development Settings  com.android.development_settings
   -  Email                 com.android.email
   -  Gallery               com.android.gallery3d
   -  Messaging             com.android.messaging
   -  Phone                 com.android.dialer
   -  Pinned                com.example.pinned
   -  Superuser             com.genymotion.superuser
```

**Step 4**
Inject the objection agent into the application
```
objection --gadget "com.guidebook.android" explore
```

**Step 5**
SSL-Pinning Bypass command
```
android sslpinning disable
```

<br/>

## Option 2

**Step 1**
```bash
# Downlaod frida-server
wget https://github.com/frida/frida/releases/download/16.0.10/frida-server-16.0.10-android-x86.xz
xz -d frida-server-16.0.10-android-x86.xz
mv frida-server-16.0.10-android-x86 frida-server

# connect to adb
adb connect 192.168.31.103:5555
adb push frida-server /data/local/tmp
adb shell

# run frida-server
su 
cd /data/local/tmp
chmod +x frida-server
./frida-server &
```

**Step 2**
Copy frida SSL Pinning Hook
```
https://codeshare.frida.re/@pcipolloni/universal-android-ssl-pinning-bypass-with-frida/
```

**Step 3**
Change the name of burp certificate on line 30 to `/burp.cer`
```
var fileInputStream = FileInputStream.$new("/data/local/tmp/cert-der.crt");
```

to
```
var fileInputStream = FileInputStream.$new("/data/local/tmp/burp.cer");
```

**Step 4**
```
frida -U -f com.example.pinned -l hook.js
```

<br/>

## Option 3

<br/>

**Step 1**
```bash
# Downlaod frida-server
wget https://github.com/frida/frida/releases/download/16.0.10/frida-server-16.0.10-android-x86.xz
xz -d frida-server-16.0.10-android-x86.xz
mv frida-server-16.0.10-android-x86 frida-server

# connect to adb
adb connect 192.168.31.103:5555
adb push frida-server /data/local/tmp
adb shell

# run frida-server
su 
cd /data/local/tmp
chmod +x frida-server
./frida-server &
```

**Step 2**
```
objection patchapk -s Guidebook_7.21.8_apkcombo.com.apk
```

**Step 3**
```
adb install Guidebook_7.21.8_apkcombo.com.apk
```
