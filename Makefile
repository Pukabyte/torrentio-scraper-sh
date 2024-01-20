# Makefile for managing Docker Compose for the project

# Variables
LOCAL_COMPOSE_FILE := docker-compose-local.yml
SALTBOX_COMPOSE_FILE := docker-compose-saltbox.yml
ARM_COMPOSE_FILE := docker-compose-arm.yml
NETWORK_NAME := torrentio

# Help
.PHONY: help
help:  ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# Detect OS and set commands accordingly
OS := $(shell uname -s)
ifeq ($(OS),Linux)
    GREP_COMMAND := grep -q
else ifeq ($(OS),Darwin)
    GREP_COMMAND := grep -q
else
    GREP_COMMAND := findstr
endif

# Detect Docker Compose command
DOCKER_COMPOSE_CMD := $(shell command -v docker-compose || echo "docker compose")

# Check if the network exists, and if not, create it
.PHONY: prepare-network
prepare-network:
	@if ! docker network ls | $(GREP_COMMAND) $(NETWORK_NAME); then \
		echo "Creating network $(NETWORK_NAME)"; \
		docker network create $(NETWORK_NAME); \
	fi

# Docker Compose Commands
.PHONY: build
build: prepare-network  ## Build or rebuild services from local compose
	$(DOCKER_COMPOSE_CMD) -f $(LOCAL_COMPOSE_FILE) build

.PHONY: up
up: prepare-network  ## Create and start containers from local compose
	$(DOCKER_COMPOSE_CMD) -f $(LOCAL_COMPOSE_FILE) up -d
	$(DOCKER_COMPOSE_CMD) -f $(LOCAL_COMPOSE_FILE) logs -f -t

.PHONY: down
down:  ## Stop and remove containers, networks from local compose
	$(DOCKER_COMPOSE_CMD) -f $(LOCAL_COMPOSE_FILE) down

.PHONY: restart
restart: down up  ## Restart all services from local compose

.PHONY: logs
logs:  ## View output from containers from local compose
	$(DOCKER_COMPOSE_CMD) -f $(LOCAL_COMPOSE_FILE) logs

.PHONY: ps
ps:  ## List containers from local compose
	$(DOCKER_COMPOSE_CMD) -f $(LOCAL_COMPOSE_FILE) ps

.PHONY: run
run: up  ## Set up everything and show logs from local compose
	@echo "Starting containers and showing logs..."
	$(DOCKER_COMPOSE_CMD) -f $(LOCAL_COMPOSE_FILE) logs -f -t

.PHONY: saltbox-run
saltbox-run:  ## Start saltbox docker-compose and show logs
	@echo "Starting containers from saltbox docker-compose.yml and showing logs..."
	$(DOCKER_COMPOSE_CMD) -f $(SALTBOX_COMPOSE_FILE) up -d
	$(DOCKER_COMPOSE_CMD) -f $(SALTBOX_COMPOSE_FILE) logs -f -t

.PHONY: saltbox-logs
saltbox-logs:  ## Show logs for saltbox docker-compose
	@echo "Showing logs from saltbox docker-compose.yml..."
	$(DOCKER_COMPOSE_CMD) -f $(SALTBOX_COMPOSE_FILE) logs -f -t

.PHONY: saltbox-restart
saltbox-restart:  ## Restart all services for saltbox docker-compose
	@echo "Restarting containers for saltbox docker-compose..."
	$(DOCKER_COMPOSE_CMD) -f $(SALTBOX_COMPOSE_FILE) restart

.PHONY: arm-run
arm-run:  ## Start arm docker-compose and show logs
	@echo "Starting containers from arm docker-compose.yml and showing logs..."
	$(DOCKER_COMPOSE_CMD) -f $(ARM_COMPOSE_FILE) up -d
	$(DOCKER_COMPOSE_CMD) -f $(ARM_COMPOSE_FILE) logs -f -t

.PHONY: arm-logs
arm-logs:  ## Show logs for arm docker-compose
	@echo "Showing logs from arm docker-compose.yml..."
	$(DOCKER_COMPOSE_CMD) -f $(ARM_COMPOSE_FILE) logs -f -t

.PHONY: arm-restart
arm-restart:  ## Restart all services for arm docker-compose
	@echo "Restarting containers for arm docker-compose..."
	$(DOCKER_COMPOSE_CMD) -f $(ARM_COMPOSE_FILE) restart
