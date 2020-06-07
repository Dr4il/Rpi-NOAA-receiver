#!/bin/sh

set -e

case "$1" in
  'install')
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
    sudo apt update && sudo apt -y install libusb-1.0 \
      cmake \
      sox \
      at \
      predict \
      nodejs
  ;;
  'blacklists')
    sudo touch /etc/modprobe.d/no-rtl.conf
    sudo echo -e "blacklist dvb_usb_rtl28xxu\nblacklist rtl2832\nblacklist rtl2830" > /etc/modprobe.d/no-rtl.conf 
  ;;
  'rtl_sdr')
    git clone https://github.com/keenerd/rtl-sdr.git
    mkdir rtl-sdr/build
    cmake -S rtl-sdr/. -DINSTALL_UDEV_RULES=ON -B ./rtl-sdr/build/
    make -C ./rtl-sdr/build/
    sudo make install -C ./rtl-sdr/build/
    sudo ldconfig
    sudo cp ./rtl-sdr/rtl-sdr.rules /etc/udev/rules.d/
  ;;
  'wxtoimg')
    wget https://wxtoimgrestored.xyz/beta/wxtoimg-armhf-2.11.2-beta.deb
    sudo dpkg -i wxtoimg-armhf-2.11.2-beta.deb
    touch ~/.wxtoimgrc
  ;;
  'wxtoimg-config')
    echo "Enter Lat/Lon cordinates"
    read -p "Set Latitude: " Lat
    read -p "Set Longitude: " Lon
    read -p "Set Altitude: " Alt
    echo "Latitude: $Lat\nLongitude: $Lon\nAltitude: $Alt" >> ~/.wxtoimgrc 
  ;;
  'predict')
    predict
  ;;
  *)

    exec "$@"
  ;;
esac

exit 0