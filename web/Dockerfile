# Use an official Node.js LTS image as the base image
FROM node:14 as build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY web/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY web/ .

# Build the React app
RUN npm run build

# Use an official Nginx image as the base image for serving the React app
FROM nginx:alpine

# Copy the built React app from the 'build' directory of the 'build' stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx server when the container starts
CMD ["nginx", "-g", "daemon off;"]
