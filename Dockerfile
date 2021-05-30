FROM node:12.20.1-alpine3.12

ENV PORT 3000
ENV SSH_PORT 2222

ADD app /usr/src/app
WORKDIR /usr/src/app
RUN npm install

ADD init_container.sh /bin/init_container.sh
ADD sshd_config /etc/ssh/

# Update permissions	
RUN chmod 755 /bin/init_container.sh
RUN apk add --update openssh-server tzdata openrc openssl \
        && echo "root:Docker!" | chpasswd \
        && rm -rf /var/cache/apk/* \
        # Remove unnecessary services
        && rm -f /etc/init.d/hwdrivers \
                 /etc/init.d/hwclock \
                 /etc/init.d/mtab \
                 /etc/init.d/bootmisc \
                 /etc/init.d/modules \
                 /etc/init.d/modules-load \
                 /etc/init.d/modloop \
        # Can't do cgroups
        && sed -i 's/\tcgroup_add_service/\t#cgroup_add_service/g' /lib/rc/sh/openrc-run.sh \
        && apk add --no-cache bash; 
        
EXPOSE 3000 2222
# CMD npm start
ENTRYPOINT ["/bin/init_container.sh"]
