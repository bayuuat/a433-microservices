# Gunakan base image Node.js versi 14
FROM node:14-alpine

# Tentukan working directory di dalam container
WORKDIR /app

# Salin seluruh source code ke working directory di container
COPY . .

# Set environment untuk production dan set host database
ENV NODE_ENV=production \
    DB_HOST=item-db

# Instal dependencies untuk production dan build aplikasi
RUN npm install --production --unsafe-perm && npm run build

# Ekspose port yang digunakan oleh aplikasi
EXPOSE 8080

# Jalankan aplikasi saat container diluncurkan
CMD ["npm", "start"]
