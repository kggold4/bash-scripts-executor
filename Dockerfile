FROM alpine:3.14

WORKDIR /executor

COPY executor.sh /executor/

RUN chmod +x /executor/executor.sh

RUN ls -lah

CMD ["sh", "executor.sh"]