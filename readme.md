## TODO project Laravel+Vue

How to run:
- Go to project root folder.
- Start containers: ```docker-compose up --build```
- Connect to container: ```docker-compose exec php bash```
- In container run next commands:
    - ```composer install```
    - ```php artisan migrate:fresh```
    - ```npm install```
- Go to ```http://localhost:8080/```    


