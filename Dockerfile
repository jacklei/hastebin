FROM node:alpine AS build

LABEL maintainer="jacklei1589@gmail.com"

WORKDIR /app

RUN apk add --no-cache git && \
    git clone https://github.com/toptal/haste-server.git /app && \
    npm install && \
    npm install aws-sdk

FROM node:alpine 

WORKDIR  /app
COPY --from=build /app .
COPY ./app.sh .
RUN chmod 755 app.sh

EXPOSE 7777

ENV STORAGE_TYPE file

CMD [ "./app.sh" ]
