# Тествое приложение на [OpenResty](//openresty.org)<sup>тм</sup>

## Установка 

### после создания папки OpenResty

~~~bash
mkdir ~/work
cd ~/work
mkdir logs/ conf/
~~~

### нужно склонировать приложение в папку app

~~~bash
git clone git@github.com:larionturlo/open_resty_app.git app
~~~

### и прописать в конфиг nginx-а `content_by_lua_file`

~~~nginx
worker_processes  1;
error_log logs/error.log;
events {
    worker_connections 1024;
}
http {
    server {
        listen 8080;
        set $template_root ./app/templates;
        location / {
            default_type text/html;
            access_by_lua_file  'app/access.lua';
            content_by_lua_file 'app/init.lua';
        }
        location /login {
            default_type text/html;
            content_by_lua_file 'app/login.lua';
        }
    }
}
~~~