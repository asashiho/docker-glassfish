# glassfishでWebアプリケーションをデプロイする
# 
# ベースイメージの取得
FROM glassfish:4.1-jdk8

# 作成者情報
MAINTAINER 0.1 asashiho@mail.asa.yokohama

# 環境変数の設定
ENV GLASSFISH_HOME /usr/local/glassfish4
ENV PASSWORD glasspass
ENV TMPFILE /tmp/passfile

# 管理者パスワードとセキュリティの設定
RUN echo "AS_ADMIN_PASSWORD=" > $TMPFILE && \
    echo "AS_ADMIN_NEWPASSWORD=${PASSWORD}" >> $TMPFILE  && \
    asadmin --user=admin --passwordfile=$TMPFILE change-admin-password --domain_name domain1 && \
    asadmin start-domain && \
    echo "AS_ADMIN_PASSWORD=${PASSWORD}" > $TMPFILE && \
    asadmin --user=admin --passwordfile=$TMPFILE enable-secure-admin && \
    asadmin --user=admin stop-domain && \
    rm $TMPFILE

# warコンテンツの配置
ADD WebAPSample.war $GLASSFISH_HOME/glassfish/domains/domain1/autodeploy

# ポートの解放
EXPOSE 4848 8080 8181

# glassfishの実行
CMD ["asadmin", "start-domain", "-v"]
