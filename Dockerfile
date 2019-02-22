
FROM ubuntu

ENV TZ=Asia/Shanghai \
    LC_ALL=C.UTF-8 \
    NODE_VERSION=10.14.1

WORKDIR /app



RUN export DEBIAN_FRONTEND=noninteractive \
 && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
 && apt-get update \
 && apt-get install -y vim curl wget git \
 && apt-get install -y python3 python3-pip && pip3 install -U pip \
 && cd /tmp && curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
 && rm -rf /var/lib/apt/lists/* /tmp/* 

COPY package.json .
RUN npm install 

COPY . .
RUN npm run check  \
 && npm run build 

EXPOSE 1337 
CMD npm start
 