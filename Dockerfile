FROM aweiker/alpine-elixir

ENV PORT=3000 MIX_ENV=development

RUN mkdir -p /cron_api

WORKDIR /cron_api

COPY mix.exs /cron_api/
RUN mix local.hex --force
RUN mix deps.get

COPY . /cron_api/

EXPOSE $PORT

CMD ["iex", "-S",  "mix"]
