# Downlaod frida-server
wget https://github.com/frida/frida/releases/download/16.0.10/frida-server-16.0.10-android-arm64.xz
xz -d frida-server-16.0.10-android-arm64.xz
mv frida-server-16.0.10-android-arm64 frida-server

# connect to adb
adb connect 192.168.31.103:5555
adb push frida-server /data/local/tmp
adb shell
