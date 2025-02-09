# wordpress-podman-development
A development enviroment for WordPress supporting SSL using podman containers.

# Prerequisites
This expect that you have both podman and podman compose installed and configuired. See the [Podman Installation Documentation](https://podman.io/docs/installation) for details. Podman is installed by default on current versions of Fedora but some additional configuration is required to use podman compose.

## Usage
The first thing you will probably want to do is update the compose.yml file, specifically to update the overall name as well as the individual service names so you can more easily identify them.

Then you'll want to build the image, you can do that with `podman compose build` then is should be a simple as `podman compose up` to get the server running and ready for use. Visiting [localhost:4433](https://localhost:4433/) should prompt you to begin the WordPress installation process.

On first run it will create two directories, `db-data` and `wp-data`. These files are what they say on the tin and give you full access to whatever you may realistically need to build a WordPress site.

Here is a breakdown of the files and what they are responsible for.

### Containerfile
This build the container, it is basically just the default official WordPress container. This probably won't need to be modified unless you're installing new stuff like WP-cli.

### compose.yml
This is the compose file, it's pretty basic and starts the WordPress and database servers. If you want to change the ports, or change up the volumes, this is where you'd do that.

### apache-vhosts.conf
This is used by apache inside the WordPress container to set up the environment. You shouldn't need to modify this if you are just using this for development as intended but if you do risk it in product that is where you would make any of your apache vhost changes like server aliases. Ports inside the WordPress container are the normal `80` and `443`, if you want to change those that should be done in the `compose.yml` file.

### overrides.php.ini
This will allow you to apply overrides to the default PHP.ini. This is used to increase max upload size and execution time. This too should generally not need to be messed with for development purposes.

## Notes
This is essentially a direct copy of [Tim Santeford's Guide](https://www.timsanteford.com/posts/docker-wordpress-environment-with-https-in-5-steps/) with some minor changes mostly done as personal preference. It's only really been tested and used on Fedora, but due to the nature of containerization it should work pretty much anywhere. 

This was intended for local development and as such no thought or consideration has been given to it's use in a production environment. It should be fine but I'm still putting that out there.

Some additional ideas I had that I did not implement as theyh were not needed at the time are:
- Settings up WPCLI, either inside the WP container or in it's own.
- Setting it up to only use one container by installing the DB into the WordPress container. This is just because I think it would be neater to only have one entry per use (and unless you're really in the weed in WordPress you aren't going to need to worry about the differences during development).