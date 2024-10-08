postgres:
	docker run --name postgresalpine -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb: 
	docker exec -it postgresalpine createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgresalpine dropdb simple_bank

migrateup:
	 migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	 migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate


.PHONY: postgres createdb dropdb migrateup migratedown