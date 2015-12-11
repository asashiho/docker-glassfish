Docker動作確認用イメージサンプル
======================
Dockerはコンテナ仮想化技術を使ったアプリケーション実行環境構築・運用プラットフォームです。  　　

このDockerfileは、以下の環境を構築します
* GlassFish公式イメージでWebアプリケーション実行環境を作成
* GlassFish管理ツールのログインIPとパスワードを設定
* サンプルアプリケーション(WebAPSample.war)をデプロイ
* ホストマシンの8080番ポートと4848番ポート(管理ツール)を転送

#### 管理ツール
https://（コンテナのアドレス）:4848/  
ログインID：admin
パスワード:glasspass

#### サンプルアプリケーションの動作確認
http://（コンテナのアドレス）:8080/WebAPSample/index.xhtml  

Usage
------
    $ docker pull asashiho/docker-glassfish

    $ docker run -d -p 4848:4848 -p 8080:8080 asashiho/glassfish

### Docker公式サイト
> https://www.docker.com/
>

### GlassFish公式サイト
> https://glassfish.java.net/
>