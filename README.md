figleaf
=======

Docker image which manages multiple children containers using Fig

Usage
-----

Create a new directory (or git repository) containing a Dockerfile
modeled after the following example:

'''
FROM ewindisch/figleaf
'''

Yes. That is it. One line. There is nothing more to do in the Dockerfile.

Then, you simply drop a fig.yml file into the directory with your Dockerfile.

Finally, you 'build':

'''
$ docker build -t my_container_pod .
'''

License
-------
Apache 2 License

Authors
-------
Eric Windisch <ewindisch@docker.com>
