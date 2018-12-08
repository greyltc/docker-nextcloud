FROM greyltc/lamp
MAINTAINER Grey Christoforo <grey@christoforo.net>
# Report issues with this to the GitHub project: https://github.com/greyltc/docker-nextcloud/issues
# Say thanks by adding a star or a comment here: https://registry.hub.docker.com/u/greyltc/nextcloud/
# and/or starring the project on GitHub

# uncomment this to update the container's mirrorlist
#RUN get-new-mirrors

# we listen for https connections
EXPOSE 443

# set environmnt variable defaults
ENV TARGET_SUBDIR nextcloud
ENV ALLOW_INSECURE false

# do the install things
ADD installNextcloud.sh /usr/sbin/install-nextcloud
RUN install-nextcloud

# add our config.php stub
ADD configs/config.php /usr/share/webapps/nextcloud/config/config.php
RUN chown http:http /usr/share/webapps/nextcloud/config/config.php; \
    chmod 0640 /usr/share/webapps/nextcloud/config/config.php

# add our cron stub
ADD configs/cron.conf /etc/cron.d/nextcloud

# add our apache config stub
ADD configs/apache.conf /etc/httpd/conf/extra/nextcloud.conf

# start the servers, then wait forever
CMD start-servers; sleep infinity
