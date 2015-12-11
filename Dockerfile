# glassfishでWebアプリケーションをデプロイする
# 
# ベースイメージの取得
FROM glassfish:4.1-jdk8

# 作成者情報
MAINTAINER 0.1 asashiho@mail.asa.yokohama

# 環境の設定
ENV GLASSFISH_HOME /usr/local/glassfish4
ENV PASSWORD glasspass

# warコンテンツの配置

ADD WebAPSample.war $GLASSFISH_HOME/glassfish/domains/domain1/autodeploy


RUN echo "--- Setup the password file ---" && \
    echo "AS_ADMIN_PASSWORD=" > /tmp/glassfishpwd && \
    echo "AS_ADMIN_NEWPASSWORD=${PASSWORD}" >> /tmp/glassfishpwd  && \
    echo "--- Enable DAS, change admin password, and secure admin access ---" && \
    asadmin --user=admin --passwordfile=/tmp/glassfishpwd change-admin-password --domain_name domain1 && \
    asadmin start-domain && \
    echo "AS_ADMIN_PASSWORD=${PASSWORD}" > /tmp/glassfishpwd && \
    asadmin --user=admin --passwordfile=/tmp/glassfishpwd enable-secure-admin && \
    asadmin --user=admin stop-domain && \
    rm /tmp/glassfishpwd


# ポートの解放
EXPOSE 8080

# glassfishの実行
#MD ["asadmin","change-admin-password","admin","","password","password"]
#CMD ["asadmin","enable-secure-admin","admin","password"]
#CMD ["asadmin","stop-domain"]
CMD ["asadmin","start-domain","--verbose"]
