# Postfix

![Postfix logo](mysza.png)

Docker Postfix image configured to act as a relay host.

## Configuration

The image is provided with a default Postfix configuration file `main.cf.template` which is used to create the actual configuration file when the container starts. The values are read from the following enviroment variables:

- `POSTFIX_DOMAIN`
- `POSTFIX_RELAY_HOST`
- `POSTFIX_RELAY_PORT`
- `POSTFIX_RELAY_USERNAME`
- `POSTFIX_RELAY_PASSWORD`

## Running

With basic Docker knowledge it's pretty straightforward to build and run the image, after having adapted the provided files to suit your needs.

A default `docker-compose-template.yml` file has been provided for Swarm clusters for test purposes.

If running in production it's better to use a Kubernetes cluster with the enviroment variables stored as secrets.
