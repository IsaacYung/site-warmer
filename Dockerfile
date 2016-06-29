FROM rails:onbuild
RUN apt-get update
RUN gem install foreman

WORKDIR /usr/src/app

CMD foreman start
