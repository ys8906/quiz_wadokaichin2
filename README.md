# クイズ和銅開珎
- 4つの二字熟語に共通する漢字を当てるクイズ

## Dependencies
- Ruby 2.6.5
- Rails 6.0.2
- Vue 2.6.11
- MySQL 5.7

## Build Setup

### Docker
```
$ docker-compose up --build
$ docker-compose run web rails db:create db:migrate db:seed_fu
```

### In Local
```
$ bundle install
$ rails db:migrate
$ rails s
```
※credentialsの共有が必要
