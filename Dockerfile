# Gunakan Node.js official image
FROM node:18-alpine

# Set working directory di dalam container
WORKDIR /app

# Copy package.json dan package-lock.json untuk instalasi dependencies
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy seluruh kode aplikasi
COPY . .

# Expose port yang akan digunakan aplikasi
EXPOSE 3001

# Health check untuk memastikan container berjalan dengan baik
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD ps aux | grep "node index.js" | grep -v grep || exit 1

# Command untuk menjalankan aplikasi
CMD ["npm", "start"] 