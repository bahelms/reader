FROM msaraiva/elixir-dev

RUN mkdir /app && \
    apk --update add bash && \
    rm -rf /var/cache/apk/*

WORKDIR /app
COPY . /app

RUN mix hex.info
RUN mix compile

EXPOSE 4000
CMD ["mix", "phoenix.server"]
