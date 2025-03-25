FROM nginx:stable AS run
COPY nginx/*.conf /etc/nginx/conf.d/
COPY dist/sample-webapp/browser /usr/share/nginx/html
WORKDIR /usr/share/nginx/html
