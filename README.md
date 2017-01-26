# docker-nextcloud
[![](https://images.microbadger.com/badges/version/greyltc/nextcloud.svg)](http://microbadger.com/images/greyltc/nextcloud) [![](https://images.microbadger.com/badges/image/greyltc/nextcloud.svg)](https://microbadger.com/images/greyltc/nextcloud)

This is just like [my ownCloud server Docker container repo](https://github.com/greyltc/docker-owncloud/) only it's for [Nextcloud](https://nextcloud.com). [Here is some background](http://fortune.com/2016/06/03/what-happened-to-owncloud/) relating to the ownCloud/Nextcloud fissure.

Simple to use Docker container with the latest stable Nextcloud server release, complete with all the bells and whistles. This project is 100% transparent and trustable, every file in the resulting docker image is traceable and inspectable by following up the docker image depenancy tree which starts with [my Arch Linux base image](https://github.com/greyltc/docker-archlinux).

Please report any issues or improvement ideas to [the github issue tracker](https://github.com/greyltc/docker-nextcloud/issues)  
Pull requests welcome! Let's work together!

Say thanks by adding a star [here](https://github.com/greyltc/docker-nextcloud/) and/or [here](https://registry.hub.docker.com/u/greyltc/nextcloud/).

### Usage

1. [**Install docker**](https://docs.docker.com/installation/)
1. **Download and start the Nextcloud server instance**  

  ```
docker pull greyltc/nextcloud
docker run --name nc -p 80:80 -p 443:443 -d greyltc/nextcloud
```
1. **Access your Nextcloud server**  
Point your web browser to __https://localhost/nextcloud__  
__Note:__ If you're on MacOS or Windows you can't use "localhost" here. Run `docker-machine ip default` to figure out what you should use in place of localhost.
1. **Setup nextcloud**  
Follow the instructions in your browser to perform the initial setup of your server.

1. **[Optional] Stop the server instance**

  ```
docker stop nc
```
You can restart the container later with `docker start nc`
1. **[Optional] Delete the server instance**  

  ```
docker rm nc #<--WARNING: this will delete anything stored inside the container
```
1. **Profit.**

**Updating Nextcloud**

Periodically new NextCloud server versions will be released. You should probably keep your server on whatever the latest stable version is. Whenever a new update is released, you'll see a banner appear across the top of the NextCloud web interface indicating that it's time to upgrade. I do not reccommend somehow switching your already running NextCloud server to a new version of this container (although you're welcome to try if your data isn't critical).  


You should follow [the official NextCloud upgrade instructions](https://docs.nextcloud.com/server/11/admin_manual/maintenance/update.html) for updating your NextCloud server. You'll need to change the permissions of some files in the container to allow them to be updated this way. I've tried to make this straightforward by including a script to manage the permissions for you. Before you run the updater app (as described in the official instructions), run `docker exec -it nc sh -c 'set-nc-perms upgrade'`. Then after you've completed the upgrade, set the permissions back to their "safer" default values like this: `docker exec -it nc sh -c 'set-nc-perms runtime'`. Where `nc` is the name you chose when running your container.
