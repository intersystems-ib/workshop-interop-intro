## multi-stage image to build & run angular app

########
## build: angular app distribution package 
######## 
FROM node:22-alpine AS build

# angular build options
ARG NG_BUILD_OPTS

# -- copy app files
RUN mkdir /app && chown node:node /app
WORKDIR /app
USER node
COPY --chown=node:node . .

# -- install deps & build distribution
RUN npm install
RUN echo ${NG_BUILD_OPTS}
RUN npm run ${NG_BUILD_OPTS}

########
## run: run angular app using nginx
########
FROM nginx:stable AS run
COPY nginx/*.conf /etc/nginx/conf.d/
COPY --from=build /app/dist/sample-webapp/browser /usr/share/nginx/html
WORKDIR /usr/share/nginx/html
