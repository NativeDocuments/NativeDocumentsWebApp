# sudo docker build -t nativedocumentswebappproxy .
# sudo docker run --name ndwebappproxy --link ndwebapp:ndwebapp -p 80:80 -d nativedocuments/nativedocumentswebappproxy

FROM nginx
ARG GA_ID  # Google Analytics ID
ADD http://downloads.nativedocuments.com/NativeDocumentsWebAppProxy.tar.gz /tmp/
RUN tar xzf /tmp/NativeDocumentsWebAppProxy.tar.gz -C /opt
RUN rm -f /tmp/NativeDocumentsWebAppProxy.tar.gz
RUN rm /etc/nginx/conf.d/default.conf
RUN [ -z "$GA_ID" ] | sed -i s/'<!--ANALYTICS-->'/"<script>(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)})(window,document,'script','https:\/\/www.google-analytics.com\/analytics.js','ga');ga('create', '$GA_ID', 'auto');ga('send', 'pageview');<\/script>"/g /opt/NativeDocumentsWebAppProxy/wwwroot/app.html
RUN rm -f /opt/NativeDocumentsWebAppProxy/wwwroot/app.html.bak
CMD ["/opt/NativeDocumentsWebAppProxy/NativeDocumentsWebAppProxy.sh"]
EXPOSE 80
