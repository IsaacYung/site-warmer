##Site Warmer

A simple application to hit a `get` into all pages of website, to keep the website cache warm, and run a slack bot to give the execution status

###Requirements

- Docker

###Running

Clone this repository

```
git clone git@github.com:renatomenegasso/site-warmer.git site-warmer
```

Run docker composer:

```
SLACK_TOKEN=223232 SITEMAP=https://www.uol.com.br/sitemap.xml docker-compose up
```

Env variables needed:

- `SITEMAP`: url of sitemap containing urls to hit
- `SLACK_TOKEN`: the token of slack bot

When you start the `docker-compose`, the slack bot will be available and the site warmer will be run into every 50 minutes

###Development
[TODO]