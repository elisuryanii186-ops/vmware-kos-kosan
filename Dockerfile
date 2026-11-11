# Base image Node.js
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy semua file aplikasi
COPY . .

# Expose port
EXPOSE 3000

# Environment variables (akan dioverride oleh docker-compose)
ENV NODE_ENV=production

# Start aplikasi
CMD ["node", "server.js"]
