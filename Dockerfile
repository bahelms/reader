FROM msaraiva/elixir-dev

RUN mkdir /app && \
    apk --update add bash && \
    rm -rf /var/cache/apk/*

WORKDIR /app
COPY . /app

ENV MIX_ENV prod
RUN mix hex.info
RUN mix deps.get
RUN mix compile

EXPOSE 80
CMD ["mix", "phoenix.server"]
