##Site Warmer

A simple application to hit a `get` into all pages of website, to keep the website cache warm, and run a slack bot to give the execution status

###Requirements

- Ruby 2.3
- Redis
- Gem bundler: `gem install bundler`
- Gem foreman: `gem install foreman`

###Running

Clone this repository

```
git clone git@github.com:renatomenegasso/site-warmer.git site-warmer
```

Install dependencies

```
bundle install
```

Export the needed env variables:

- `SITEMAP`: url of sitemap containing urls to hit
- `SLACK_TOKEN`: the token of slack bot

Start the services

```
foreman start
```


###Using

Just start the processes with the given env variables. The job will warm the website every 50 minutes, and store the result. If you use cloudflare, the _cold urls_ will be stored.
