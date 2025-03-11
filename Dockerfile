FROM node:20-alpine

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build

# Use Nginx for serving the built app
FROM nginx:alpine

# Copy the built app from the previous stage
COPY --from=build /app/dist /usr/share/nginx/html

# Expose the correct port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]