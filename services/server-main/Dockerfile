# ---------- BUILD STAGE ----------
FROM node:24-alpine3.21 AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .

# ---------- RUNTIME STAGE ----------
FROM node:24-alpine3.21

# Security: non-root user
RUN addgroup -S app && adduser -S app -G app

WORKDIR /app

# Copy only prod deps
COPY --from=builder /app/package*.json ./
RUN npm ci --omit=dev && npm cache clean --force

# Copy only app source (no node_modules from builder)
COPY --from=builder /app/index.js ./index.js
# If you have src folder
# COPY --from=builder /app/src ./src

USER app

EXPOSE 5001
CMD ["node", "index.js"]

