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

### todo
- 遅すぎる問題
  - 正直何をどう調べたものか
  - gcpで試してみる？
- cap * cronがうまくいかない問題
  - 手動更新
    - ssh quiz_wadokaichin_key_rsa
    - crontab -e
    - V -> d
    - cd /var/www/rails/Quiz/current
    - whenever --update-crontab
- seo

### メモ
- ssh
  - ssh quiz_wadokaichin_key_rsa
- サーバー再起動
  - cd /var/www/rails/Quiz/current
  - sudo service nginx restart
  - ps -ef | grep unicorn | grep -v grep
  - kill 番号
  - bundle exec unicorn_rails -c /var/www/rails/Quiz/current/config/  - unicorn.conf.rb -D -E production
  - ps -ef | grep unicorn | grep -v grep

- ログ削除
  - cd /var/www/rails/Quiz/current/shared/log
  - sudo du -h --max-depth=1
  - rm development.log nginx.error.log unicorn.log whenever.log     nginx.- access.log production.log unicorn_err.log
  - サーバー再起動
  - df -h

- credential編集
  - docker-compose run -e EDITOR="vim" web rails credentials:edit
  