figleaf
=======

Docker image which manages multiple children containers using Fig

Usage: method #1 - Build hierarchial container image
----------------------------------------------------

Create a new directory (or git repository) containing a Dockerfile
modeled after the following example:

```FROM ewindisch/figleaf```

Yes. *That is it*. One line. **There is nothing more to do in the Dockerfile.**

Then, you simply drop a fig.yml file into the directory with your Dockerfile.

Finally, you 'build':

```$ docker build -t my_container_pod .```

The resultant image must either be given an existing Docker socket, or be run privileged.

Example running privileged:

```$ docker run --privileged my_container_pod```

Example running with a passed socket:

```$ docker run -v /var/run/docker.sock:/var/run/docker.sock my_container_pod```


Usage: method #2 - Pass-in a fig.yml file.
------------------------------------------

Assuming your fig.yml file is in the current directory, run:
```
docker run --privileged -v $PWD:/opt/figapp ewindisch/figleaf
```

As above, it is also possible to pass an existing socket when passing a fig.yml file.


Notes for Docker-in-Docker support
----------------------------------

Docker-in-Docker (DinD) is used whenever a socket is NOT passed to the
container. DinD, by default, configures the VFS driver as this is the
lowest-common-denominator. This driver also happens to allow 'docker
pull' from the build context.

To configure another storage driver from your Dockerfile:

    FROM ewindisch/figleaf
    ENV STORAGE_DRIVER aufs  # or devicemapper, overlayfs, etc...

To configure from the command-line:

    docker run --privileged -e STORAGE_DRIVER=devicemapper my-fig-app


Seeding with images
-------------------

If running figleaf with DinD, it may be valuable to seed images during
the 'docker build', from within the Dockerfile.

As long as the VFS driver is used, this is actually quite simple.
This image comes with a wrapper for docker and fig which
automatically allow RUN statements for their pull commands to function
correctly from a build context.

For example:

```
FROM ewindisch/figleaf
RUN fig pull
RUN docker pull busybox
```

You would then build this in a directory containing a fig.yml file,
which presumably would compose a set of containers using these images.

Users of other storage drivers will find this slower and more complex,
but if caching images during build is necessary, it should be
possible to do something like:

```
# NOTE this example has not been tested... YMMV
# this is probably not the ideal use of figleaf...
FROM ewnidisch/figleaf
RUN docker pull busybox; \
    docker save > /opt/figapp/busybox.img
CMD wrapdocker; \
    docker load < /opt/figapp/busybox.img; \
    fig up
```

License
-------
Apache 2 License

Authors
-------
Eric Windisch <ewindisch@docker.com>
