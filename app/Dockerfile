FROM node:12-alpine as builder
ENV NODE_ENV production
WORKDIR /app
COPY package.json ./
COPY package-lock.json ./
RUN npm install --production --silent
COPY . .
EXPOSE 3000
CMD ["npm", "start"]


#RUN npm run build

# FROM nginx:1.21.0-alpine as production
# ENV NODE_ENV production
# COPY --from=builder /app/build /usr/share/nginx/html
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]