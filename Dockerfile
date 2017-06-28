# sudo docker build -t nativedocumentswebapp .
# sudo docker run --name ndwebapp --link ndrenderer:ndrenderer -p 8080:80 -d nativedocuments/nativedocumentswebapp

FROM nginx
ARG GA_ID=
ARG version_suffix=
ADD http://downloads.nativedocuments.com/NativeDocumentsWebApp${version_suffix}.tar.gz /tmp/
RUN tar xzf /tmp/NativeDocumentsWebApp${version_suffix}.tar.gz -C /opt
RUN rm -f /tmp/NativeDocumentsWebApp${version_suffix}.tar.gz
RUN rm /etc/nginx/conf.d/default.conf
RUN [ -z "$GA_ID" ] | sed -i s/'<!--ANALYTICS-->'/"<script>(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)})(window,document,'script','https:\/\/www.google-analytics.com\/analytics.js','ga');ga('create', '$GA_ID', 'auto');ga('send', 'pageview');<\/script>"/g /opt/NativeDocumentsWebApp/wwwroot/app.html
RUN rm -f /opt/NativeDocumentsWebApp/wwwroot/app.html.bak
CMD ["/opt/NativeDocumentsWebApp/NativeDocumentsWebApp.sh"]
EXPOSE 80
