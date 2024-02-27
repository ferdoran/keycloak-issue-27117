.PHONY: start
start:
	docker compose down || true
	docker compose up --build
