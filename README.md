##Site Warmer

A simple application to hit continuous `get` into all pages of some website, to keep the website into top of cdns networks execution status. Also, this application runs a slack bot, to get status.

To tell how urls to perform `get`:
- Passing `SITEMAP` env variable: the app will fetch all urls from sitemaps to hit
- If your site is managed by wordpress, you can fill the connection env variables (described bellow). This application will access the database and get all posts and categories. If you have the yoast plugin, the redirects stored

*Important*: If your site is behind the cloudflare, this application will work properly. If don't, the reports will be stored with wrong data, but the warmer will work

###Requirements

- Docker
- Docker compose

###Running into production

Download the sample `docker-compose.yml` file:

```
curl https://raw.githubusercontent.com/renatomenegasso/site-warmer/master/docker-compose.yml > docker-compose.yml
```

To run and fetch urls from sitemap:

```
SLACK_TOKEN=223232-sasad-x-asa SITEMAP=https://somesite.com/sitemap.xml docker-compose up
```

To run and fetch urls from wordpress:

```
SLACK_TOKEN=223232-sasad-x-asa WP_DB_HOST=<the_host> WP_DB_SCHEMA=<your_db> WP_DB_USER=<db_user> WP_DB_PASS=<db_pass> docker-compose up
```

When you start the `docker-compose`, the slack bot will be available and the site warmer will be run continuously

###Slackbot commands

Actuallty, the slack bot accepts the follow instructions:

- _O cache está quente?_ : tell if the site is warm
- _Quais urls estavam frias_ : tell that urls misses from cache
- _Quero um status_ : Send the detailed report of last execution

###Development
[TODO]
