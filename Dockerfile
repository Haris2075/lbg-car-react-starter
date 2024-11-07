# Step 1: Build the React app
FROM node:14 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock) to install dependencies
COPY package.json package-lock.json ./

# Install the dependencies
RUN npm install

# Copy the entire React source code into the container
COPY . .

# Build the React application for production
RUN npm run build

# Step 2: Serve the React app using nginx
FROM nginx:alpine

# Copy the build directory from the build stage into the nginx container
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to access the app
EXPOSE 8000

# Command to run nginx (by default, nginx will serve the static files)
CMD ["nginx", "-g", "daemon off;"]
