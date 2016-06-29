FROM rails:onbuild
RUN apt-get update
RUN apt-get install postgresql-client
RUN gem install foreman

WORKDIR /usr/src/app

CMD foreman start
