####################
#
# Alias:
#     alias kali='docker run -it --rm --privileged --net="host" -v `pwd`:/app kanalfred/kali /bin/bash'
# Run:
#     docker run --name php-nginx -p 8080:80 -v /home/alfred/workspace/docker/docker-php-nginx/code:/code -d kanalfred/php-nginx
# Build:
#     docker build -t kanalfred/kali .
#
####################

FROM kalilinux/kali-linux-docker

RUN apt-get update \
    && apt-get install -y wireless-tools \
            metasploit-framework \
            aircrack-ng \
            pciutils \
            vim 

### Custom ###
#COPY etc /etc/

#EXPOSE 80 443 9000
#CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
