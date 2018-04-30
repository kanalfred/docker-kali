####################
# Give docker user permission for local x11
# xhost +local:docker
#
# Alias:
#     alias kali='docker run -it --rm --privileged --net="host" --name kali --hostname kali -v `pwd`:/app -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix kanalfred/kali /bin/bash'
# Run:
#     docker run --name php-nginx -p 8080:80 -v /home/alfred/workspace/docker/docker-php-nginx/code:/code -d kanalfred/php-nginx
# Build:
#     docker build -t kanalfred/kali .
# Refer:
#     https://unix.stackexchange.com/questions/381155/how-to-get-access-to-host-wifi-interface-from-docker-container
#     https://hackingvision.com/2017/02/18/kali-linux-man-in-the-middle-attack/
# Command:
#     find package: apt-cache search arpspoof
#     launch ettercap graphic: ettercap -G
#
####################

FROM kalilinux/kali-linux-docker

RUN apt-get update \
    && apt-get install -y wireless-tools \
            net-tools \
            metasploit-framework \
            aircrack-ng \
            pciutils \
            netdiscover \
            dsniff \
            driftnet \
            bettercap \
            sslstrip \
            ettercap-graphical \
            vim 

### Custom ###
#COPY etc /etc/

EXPOSE 80 8080 9000
#CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
