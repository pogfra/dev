## GESTION DES CONTAINERS
.PHONY: up down build config prune shell logs

up: # Start up containers
	@docker compose up -d --remove-orphans
down: # Stop containers
	@docker compose down
build: # Build containers
	@docker compose up -d --remove-orphans --build
config: # Print config
	@docker compose config
prune: # Remove containers and volumes
	@docker compose down -v $(filter-out $@,$(MAKECMDGOALS))
shell:
	@docker compose exec app /bin/bash
shell-root:
	@docker compose exec -u 0:0 app /bin/bash
logs:
	@docker compose logs -f

%:
	@:
