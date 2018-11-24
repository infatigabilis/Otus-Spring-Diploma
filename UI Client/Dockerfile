FROM node:alpine as react-build
COPY . /app/
WORKDIR /app
RUN npm install
RUN npm run-script build

FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=react-build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]