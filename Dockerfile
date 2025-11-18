# ---- Base Image ----
FROM node:18-alpine

# ---- Install Dependencies for SQLite & Google Vision ----
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    sqlite-dev \
    sqlite

# ---- Create App Directory ----
WORKDIR /app

# ---- Copy and Install Node Packages ----
COPY package.json package-lock.json* ./
RUN npm install --production

# ---- Copy Application Files ----
COPY . .

# ---- Create SQLite DB Directory ----
RUN mkdir -p /app/data

# ---- Make Upload Directory ----
RUN mkdir -p /app/uploads

# ---- Environment Variables ----
ENV PORT=8080
ENV GOOGLE_APPLICATION_CREDENTIALS="/app/google-key.json"

# ---- Expose API Port ----
EXPOSE 8080

# ---- Start Server ----
CMD ["node", "index.js"]
