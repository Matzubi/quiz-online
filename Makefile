.PHONY: bootstrap lint fmt test

bootstrap:
	@echo "Installing dev dependencies..."
	npm install --prefix svc/gateway
	npm install --prefix svc/event-ingest
	npm install --prefix stream/consumer

lint:
	npx prettier -c "**/*.{js,ts,md,yaml,yml,json}"

fmt:
	npx prettier -w "**/*.{js,ts,md,yaml,yml,json}"

test:
	@echo "No tests yet"

up:  ; docker compose -f infra/compose/docker-compose.yml up -d
down:; docker compose -f infra/compose/docker-compose.yml down
