# INSTALL PC
```
sudo -i
curl https://raw.githubusercontent.com/MarcO-79/tbs-rpi/main/drv-tbs-pc.sh | sh
```
# INSTALL RPi
```
sudo -i 
curl https://raw.githubusercontent.com/MarcO-79/tbs-rpi/main/drv-tbs-rpi.sh | sh
```
# Check Driver
To check if the driver has been installed correctly, list adapters in the dvb directory:
```
ls /dev/dvb
```
Should be listed all adapters installed in the system. For example:
```
adapter0 adapter1 adapter2 adapter3 ...
```
# Troubleshooting
You can contact TBS representatives for help installing drivers at this link: https://www.tbsdtv.com/contact-us.html - select "Software installation and debugging"
If you have any issues with your DVB Adapters, please check DVB Troubleshooting
