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

ENV TERM=xterm
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
# https://github.com/beefproject/beef/issues/1290
ENV LC_ALL=C.UTF-8 

# Add Files
ADD container-files/mitmf /usr/bin/mitmf
ADD hack.txt /note/hack.txt

RUN apt-get update \
    && apt-get install -y wireless-tools \
            python-pip \
            net-tools \
            metasploit-framework \
            aircrack-ng \
            pciutils \
            netdiscover \
            dsniff \
            driftnet \
            bettercap \
            #mitmf \
            #sslstrip \
            python-dev python-setuptools libpcap0.8-dev libnetfilter-queue-dev libssl-dev libjpeg-dev libxml2-dev libxslt1-dev libcapstone3 libcapstone-dev libffi-dev file \
            ettercap-graphical \
            postgresql \
            vim 

# custom plugins
# SSlstrip2 - https://github.com/singe/sslstrip2/tree/892b014bd1b62e01f5ea0924839d08a931a6a2b1
# Dns2Proxy - https://github.com/singe/dns2proxy/tree/38428f60770fd8639e61a6bc91d6d7318086755f
#RUN cd /tmp/plugins/sslstrip2 && python setup.py install

# MINM framework
# https://github.com/byt3bl33d3r/MITMf
# sh doesn't have source command only bash has
#RUN mv /bin/sh /bin/sh_tmp && ln -s /bin/bash /bin/sh
RUN cd / \
    && pip install virtualenvwrapper \
    #&& source /usr/local/bin/virtualenvwrapper.sh \
    && echo 'source /usr/local/bin/virtualenvwrapper.sh' >> /root/.bashrc \
    #&& echo 'mkvirtualenv MITMf -p /usr/bin/python2.7' >> /root/.bashrc \
    #&& mkvirtualenv MITMf -p /usr/bin/python2.7 \
    && git clone https://github.com/byt3bl33d3r/MITMf \
    && cd MITMf && git submodule init && git submodule update --recursive \
    && pip install -r requirements.txt
#RUN rm /bin/sh && mv /bin/sh_tmp /bin/sh

# Beef framework
RUN cd / \
    && git clone https://github.com/beefproject/beef \
    && cd beef \
    && sed -i "/gem 'rake'/a gem 'xmlrpc'" Gemfile \
    && yes | ./install

# Set setoolkit
RUN cd / \
    && git clone https://github.com/trustedsec/social-engineer-toolkit/ set/ \
    && cd set \
    && yes | python setup.py install

### Custom ###
#COPY etc /etc/

EXPOSE 80 8080 9000 4444
#CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
