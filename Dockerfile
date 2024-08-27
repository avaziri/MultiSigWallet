FROM ubuntu:20.04 AS build_os
WORKDIR /app
COPY . .
EXPOSE 8282

### Stage 1 -Install dependencies
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install -y \
    libusb-1.0-0-dev \
    nodejs=10.19.0~dfsg-3ubuntu1.6 \
    npm=6.14.4+ds-1ubuntu2 \
    git \
    vim

### Stage 2 - Install dapp
FROM build_os AS build_dapp
RUN npm install node-gyp
RUN npm install -g grunt-cli
RUN npm install
RUN npm test
RUN npm run test-dapp
