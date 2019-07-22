build:
	docker build -t sergeyjay/actix-web:v1.0.0 .

run:
	docker run -p 8080:8080 sergeyjay/actix-web:v1.0.0