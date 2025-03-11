# Use Node.js 20 for building the React app
FROM node:20 AS build

# Set the working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the entire app and build it
COPY . .
RUN npm run build

# Use Nginx to serve the built React app
FROM nginx:alpine

# Copy the built files to Nginx's serving directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 for the web server
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
