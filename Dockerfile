FROM ruby:2.7.6

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  build-essential \
  curl \
  gnupg2 \
  ca-certificates \
  && mkdir -p /etc/apt/keyrings \
  && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key -o /etc/apt/keyrings/nodesource.asc \
  && echo "deb [signed-by=/etc/apt/keyrings/nodesource.asc] https://deb.nodesource.com/node_22.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends nodejs yarn \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*



WORKDIR /app

RUN bundle config --global frozen 1
COPY Gemfile Gemfile.lock ./
COPY ../ ./
RUN bundle install

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
