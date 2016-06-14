##Site Warmer

A simple application to hit a get into all pages of website, to keep the cache warm

###Requirements

- Ruby 2.3
- Redis
- Gem bundler: `gem install bundler`

###Running

Is just a standard rails application:

Clone this repository

```
git clone git@github.com:renatomenegasso/site-warmer.git site-warmer
```

Install dependencies

```
bundle install
```

Start the webserver

```
bin/rails s
```

Start the queue backend

```
bundle exec sidekiq
```

###Using

When this app is running in any server (into a heroku dyno, for instance), just make a request to root path `/`, with `sitemap_url` parameter. The application will get all urls from this sitemap, and hit one by one.
