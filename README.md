# Torrentio

- [torrentio-addon](addon) - the Stremio addon which will query scraped entries and return Stremio stream results.

*Accessible at `127.0.0.1:7000` after setting up, provides a user interface for managing and viewing streams.*

## Getting Started with Docker Compose

This works better in Linux, however Windows is also supported!

### Prerequisites

- Docker and Docker Compose should be installed on your system.

To get started, clone the repository with:

```bash
git clone https://github.com/Pukabyte/torrentio-scraper-sh.git 'torrentio-sh'
cd torrentio-sh
```

Then simply do:

```sh
docker compose -f docker-compose-local.yml up -d && docker compose logs -f
```

This will build and install everything and then bring you into the logs for all the apps. You can exit by pressing `Ctrl-C` on Windows, or `Cmd-C` on Mac.

## Getting Started with Makefile

### Running the Application

This guide uses `make` to make things smoother and to manage the Docker Compose tasks.

To get everything up and running, simply use:

```bash
make run
```

This command will set up the necessary Docker network, start all the services, and show you the logs of the running containers. If you are running this setup for the first time, it will build the necessary Docker images.

### Accessing the Application

After starting the services with `make run`, open your browser and navigate to `127.0.0.1:7000` to access the application.

### Additional Make Commands

- `make build` - Build or rebuild services.
- `make up` - Create and start containers.
- `make down` - Stop and remove containers, networks.
- `make restart` - Restart all services.
- `make logs` - View output from containers.
- `make ps` - List containers.
- `make run` - Start the local Docker Compose setup and show logs.

These commands are specific to ARM Docker Compose,

- `make arm-run` - Start the ARM Docker Compose setup and show logs.
- `make arm-logs` - Show logs for the ARM Docker Compose setup.
- `make arm-restart` - Restart all services for ARM Docker Compose

These commands are specific to Saltbox

- `make saltbox-run` - Start the Saltbox Docker Compose setup and show logs. (Uses Traefik)
- `make saltbox-logs` - Show logs for the Saltbox Docker Compose setup. (Uses Traefik)
- `make saltbox-restart` - Restart all services for Saltbox Docker Compose


For a full list of available commands, you can type:

```bash
make help
```

If you want to know exactly what the makefile commands are doing, you can simply do:
```sh
cat Makefile
```

## Final Words

Enjoy!