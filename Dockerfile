FROM registry.access.redhat.com/rhel7.2

USER root

RUN subscription-manager repos --enable rhel-server-rhscl-7-rpms
RUN subscription-manager repos --enable rhel-7-server-optional-rpms

RUN yum install -y rh-nodejs4
RUN scl enable rh-nodejs4 bash

# Create app directorys
RUN mkdir -p /usr/src/app
RUN mkdir -p /usr/src/app/img
RUN mkdir -p /usr/src/app/js
RUN mkdir -p /usr/src/app/styles

WORKDIR /usr/src/app

# Install app dependencies
ADD https://github.com/utherp0/leaderboard-docker/blob/master/package.json?raw=true /usr/src/app/package.json
ADD https://github.com/utherp0/leaderboard-docker/blob/master/index.html?raw=true /usr/src/app/index.html
ADD https://github.com/utherp0/leaderboard-docker/blob/master/options.json?raw=true /usr/src/app/options.json
ADD https://github.com/utherp0/leaderboard-docker/blob/master/img/golden.png?raw=true /usr/src/app/img/golden.png
ADD https://github.com/utherp0/leaderboard-docker/blob/master/js/main.js?raw=true /usr/src/app/js/main.js
ADD https://github.com/utherp0/leaderboard-docker/blob/master/js/nth-suffix.js?raw=true /usr/src/app/js/nth-suffix.js
ADD https://github.com/utherp0/leaderboard-docker/blob/master/styles/styles.scss?raw=true /usr/src/app/styles/styles.scss

RUN npm install

EXPOSE 8080

CMD ["npm", "start"]
