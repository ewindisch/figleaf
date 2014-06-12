figleaf
=======

Docker image which manages multiple children containers using Fig

Usage: method #1 - Build hierarchial container image
----------------------------------------------------

Create a new directory (or git repository) containing a Dockerfile
modeled after the following example:

```
FROM ewindisch/figleaf
```

Yes. That is it. One line. There is nothing more to do in the Dockerfile.

Then, you simply drop a fig.yml file into the directory with your Dockerfile.

Finally, you 'build':

```
$ docker build -t my_container_pod .
```

The resultant image must be run privileged:

```
$ docker run --privileged my_container_pid
```


Usage: method #2 - Pass-in a fig.yml file.
------------------------------------------

Assuming your fig.yml file is in the current directory, run:
```
docker run --privileged -v .:/opt/figapp ewindisch/figleaf
```

License
-------
Apache 2 License

Authors
-------
Eric Windisch <ewindisch@docker.com>
