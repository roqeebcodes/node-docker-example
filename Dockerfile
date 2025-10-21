# 1. Use a supported Node.js image (This fixes the 'stretch' EOL problem)
FROM node:20-slim

# Set the working directory variable (optional, but good practice)
ENV HOME=/home/app
ENV APP_DIR=$HOME/node_docker

# 2. Update package lists and install necessary Linux utilities (like htop)
# The node:slim image is based on Debian, so apt-get works.
RUN apt-get update && apt-get install -y htop \
    && rm -rf /var/lib/apt/lists/* # Clean up cache to keep image small

# Create the application directory
RUN mkdir -p $APP_DIR

# 3. Copy only the dependency files first
# This ensures faster rebuilds (Docker caching) if only source code changes.
COPY package.json package-lock.json $APP_DIR/

# 4. Set the working directory inside the container
WORKDIR $APP_DIR

# 5. Install dependencies
# Using --prefer-offline saves time if npm cache is available
RUN npm install --silent --progress=false

# 6. Copy the rest of the application source code
COPY . $APP_DIR

# 7. Define the command to start the application
CMD ["npm", "start"]
