FROM aweiker/alpine-elixir

ENV APP_NAME cron

COPY . /source
WORKDIR /source

RUN mix local.hex --force && mix local.rebar --force
RUN MIX_ENV=prod mix deps.get
RUN MIX_ENV=prod mix compile
RUN MIX_ENV=prod mix release --verbosity=verbose --no-confirm-missing
RUN mkdir /app && cp -r rel/$APP_NAME /app && rm -rf /source

CMD trap exit TERM; /app/$APP_NAME/bin/$APP_NAME foreground & wait
