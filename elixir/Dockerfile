FROM elixir as stage1

WORKDIR /app

COPY . /app

RUN mix local.hex --force
RUN mix deps.get compile release 
RUN ls _build/dev
FROM scratch AS export-stage

COPY --from=stage1 /app/_build/dev/webtest-0.1.0.tar.gz .
