# README

本リポジトリは、[Take off Rails](https://freelance.cat-algorithm.com) の課題である Qiita clone 作成のサンプルコードです。

- Ruby version
  2.6.2

- Configuration
  database.yml はサンプルファイルを準備しています。以下のコードを実行し、コピーしてください。

```
$ cp config/database.yml.sample config/database.yml
```

- Setup Database
  MySQL の Docker Image を使うようにしています。

```
$ docker-compose up -d
```

起動できたら db を作成しましょう。

```
$ bundle exec rails db:setup
```

- How to run the test suite
  テストは rspec を使っています。

```
$ bundle exec rspec
```
