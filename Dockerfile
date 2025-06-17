# Menggunakan Node.js versi LTS sebagai base image
FROM node:18-alpine

# Set working directory di dalam container
WORKDIR /app

# Copy package.json dan package-lock.json terlebih dahulu untuk optimisasi layer caching
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy semua file aplikasi ke container
COPY . .

# Expose port (default 3000, tapi bisa diubah melalui environment variable)
EXPOSE 3000

# Health check untuk memastikan aplikasi berjalan dengan baik
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD ps aux | grep "node index.js" | grep -v grep || exit 1

# Command untuk menjalankan aplikasi
CMD ["npm", "start"] 